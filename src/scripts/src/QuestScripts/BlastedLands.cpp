/*
 * WEmu Scripts for WEmu MMORPG Server
 * Copyright (C) 2008 WEmu Team
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "StdAfx.h"
#include "Setup.h"
#include "../Common/EasyFunctions.h"

#define SendQuickMenu(textid) objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), textid, plr); \
	Menu->SendTo(plr);

class HeroesofOld : public QuestScript
{	
public:
  void OnQuestStart(PlayerPointer mTarget, QuestLogEntry * qLogEntry)
  {
	  if( mTarget == NULL || mTarget->GetMapMgr() == NULL || mTarget->GetMapMgr()->GetInterface() == NULL )
		  return;

	CreaturePointer spawncheckcr = mTarget->GetMapMgr()->GetInterface()->GetCreatureNearestCoords(mTarget->GetPositionX(), mTarget->GetPositionY(), mTarget->GetPositionZ(), 7750);

	if(!spawncheckcr)
	{
		CreaturePointer general = sEAS.SpawnCreature(mTarget, 7750, -10619, -2997, 28.8, 4, 0);
		general->Despawn(3*60*1000, 0);
	}

	GameObjectPointer spawncheckgobj = mTarget->GetMapMgr()->GetInterface()->GetGameObjectNearestCoords(mTarget->GetPositionX(), mTarget->GetPositionY(),mTarget->GetPositionZ(), 141980);

	if(!spawncheckgobj)
	{
		GameObjectPointer generalsbox = sEAS.SpawnGameobject(mTarget, 141980, -10622, -2994, 28.6, 4, 4, 0, 0, 0, 0);
		sEAS.GameobjectDelete(generalsbox, 3*60*1000);
	}
  }
};



class HeroesofOld1 : public GossipScript
{
public:
	void GossipHello(ObjectPointer pObject, PlayerPointer plr, bool AutoSend)
	{
		if(!plr)
			return;

		GossipMenu *Menu;
		CreaturePointer general = TO_CREATURE(pObject);
		if (general == NULL)
			return;

		objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 1, plr);
		if(plr->GetQuestLogForEntry(2702) || plr->HasFinishedQuest(2702))
			Menu->AddItem( 0, "I need to speak with Corporal.", 1);
	 
		if(AutoSend)
			Menu->SendTo(plr);
	}
 
	void GossipSelectOption(ObjectPointer pObject, PlayerPointer plr, uint32 Id, uint32 IntId, const char * EnteredCode)
	{
		if(!plr)
			return;

		CreaturePointer general = TO_CREATURE(pObject);
		if (general == NULL)
			return;

		switch (IntId)
		{
			case 0:
				GossipHello(pObject, plr, true);
				break;
 
			case 1:
			{
				CreaturePointer spawncheckcr = plr->GetMapMgr()->GetInterface()->GetCreatureNearestCoords(plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ(), 7750);

				if(!spawncheckcr)
				{
					CreaturePointer general = sEAS.SpawnCreature(plr, 7750, -10619, -2997, 28.8, 4, 0);
					general->Despawn(3*60*1000, 0);
				}

				GameObjectPointer spawncheckgobj = plr->GetMapMgr()->GetInterface()->GetGameObjectNearestCoords(plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ(), 141980);

				if(!spawncheckgobj)
				{
					GameObjectPointer generalsbox = sEAS.SpawnGameobject(plr, 141980, -10622, -2994, 28.6, 4, 4, 0, 0, 0, 0);
					sEAS.GameobjectDelete(generalsbox, 3*60*1000);
				}
			}
		}
	}
 
	void Destroy()
	{
		delete this;
	}
};

void SetupBlastedLands(ScriptMgr * mgr)
{
	QuestScript *HeroesoO = (QuestScript*) new HeroesofOld();
	mgr->register_quest_script(2702, HeroesoO);

	GossipScript * gossip1 = (GossipScript*) new HeroesofOld1();
	mgr->register_gossip_script(7572, gossip1);
}
