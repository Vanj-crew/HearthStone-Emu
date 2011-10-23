/*
 * Sun++ Scripts for Ascent MMORPG Server
 * Copyright (C) 2005-2007 Ascent Team <http://www.ascentcommunity.com/>
 * Copyright (C) 2007-2008 Moon++ Team <http://sunplusplus.info//>
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
#include "../Common/Base.h"

class SCRIPT_DECL ProspectorAnvilwardGossip : public GossipScript
{
public:
	void GossipHello( Object * pObject, Player * Plr, bool AutoSend )
	{
		GossipMenu * Menu;

		Creature * pCreature = static_cast<Creature*>( pObject );
		if(pCreature==NULL)
			return;

		objmgr.CreateGossipMenuForPlayer( &Menu, pObject->GetGUID(), 8239, Plr );

		if( Plr->HasQuest( 8483 ) )
			Menu->AddItem( 0, "I need a moment of your time, sir.", 1 );

		if( AutoSend )
			Menu->SendTo( Plr );
	}

	void GossipSelectOption( Object * pObject, Player * Plr, uint32 Id, uint32 IntId, const char * Code )
	{
		GossipMenu * Menu;
		objmgr.CreateGossipMenuForPlayer( &Menu, pObject->GetGUID(), 8240, Plr );

		Creature * pCreature = (pObject->GetTypeId()==TYPEID_UNIT)?((Creature*)pObject):NULL;
		if(pCreature==NULL)
			return;

		switch( IntId )
		{
		case 0:
			GossipHello( pObject, Plr, true );
			break;

		case 1:
			{
				pCreature->SendChatMessage( CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "Ah, you must be the person assigned to show me around the Eversong Woods.  Took your sweet time getting here, didn't you? Very well, off we go.  Let us not waste one more minute." );
				Menu->AddItem( 0, "Why... yes, of course. I've something to show you right inside this building, Mr. Anvilward.", 2 );
                                Menu->SendTo( Plr );
			}break;
		case 2:
			{
			Plr->Gossip_Complete();
			if( Plr == NULL || Plr->GetMapMgr() == NULL || Plr->GetMapMgr()->GetInterface() == NULL )
					return;

			pCreature->m_runSpeed = 5;
			pCreature->GetAIInterface()->StopMovement( 3000 );
			pCreature->SetUInt32Value( UNIT_NPC_FLAGS, 0 );
			pCreature->SendChatMessage( CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "Very well. Let's see what you have to show me." );

			sEAS.CreateCustomWaypointMap( pCreature );

			sEAS.WaypointCreate( pCreature, 9291.540039f, -6682.770020f, 22.536600f, 5.759f, 500, 256, 0 );
			sEAS.WaypointCreate( pCreature, 9297.587891f, -6669.673340f, 22.402288f, 0.919f, 500, 256, 0 );
			sEAS.WaypointCreate( pCreature, 9309.375000f, -6657.662109f, 22.499689f, 1.900f, 500, 256, 0 ); 
			sEAS.WaypointCreate( pCreature, 9305.245117f, -6650.139648f, 25.762384f, 2.552f, 500, 256, 0 );
			sEAS.WaypointCreate( pCreature, 9297.402344f, -6648.088379f, 29.014349f, 3.514f, 500, 256, 0 );
			sEAS.WaypointCreate( pCreature, 9287.682617f, -6655.818359f, 31.834105f, 4.108f, 500, 256, 0 );
			}break;
		}
	}

	void Destroy()
	{
		delete this;
	}
};

class ProspectorAnvilward : public CreatureAIScript
{
public:
	ADD_CREATURE_FACTORY_FUNCTION( ProspectorAnvilward );
	ProspectorAnvilward( Creature * pCreature ) : CreatureAIScript( pCreature ) {}

	void OnReachWP(uint32 iWaypointId, bool bForwards)
	{
		if(iWaypointId == 6)
		{
			sEAS.DeleteWaypoints( _unit );
			_unit->GetAIInterface()->setMoveType( 7 );
			_unit->SetUInt32Value( UNIT_FIELD_FACTIONTEMPLATE, 16 );
			_unit->GetAIInterface()->SetAllowedToEnterCombat( true );
			_unit->Despawn(10*60*1000, 1000); //if failed allow other players to do quest from beggining
			_unit->SendChatMessage( CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, "What manner of trick is this? If you seek to ambush me, I warn you I will not go down quietly!" );
			 
		}
	}
};

bool PoweringOurDefenses(uint32 i, SpellPointer pSpell)
{
	if(!pSpell->u_caster->IsPlayer())
    return true;

	PlayerPointer plr = TO_PLAYER(pSpell->u_caster);
	if( !plr )
		return true;

	QuestLogEntry *qle = plr->GetQuestLogForEntry( 8490 );
	if( !qle )
		return true;

	// Angelis : Need to script the scourge attack

	if( qle && qle->GetMobCount(0) < qle->GetQuest()->required_mobcount[0] )
	{
		qle->SetMobCount(0, qle->GetMobCount(0)+1);
		qle->SendUpdateAddKill(0);
		qle->UpdatePlayerFields();
	}
	return true;
}

void SetupEversongWoods(ScriptMgr * mgr)
{
	mgr->register_dummy_spell(28247, &PoweringOurDefenses);
	GossipScript * Anvilward = ( GossipScript* ) new ProspectorAnvilwardGossip();
	mgr->register_gossip_script( 15420, Anvilward );
	mgr->register_creature_script( 15420, ProspectorAnvilward::Create );
}
