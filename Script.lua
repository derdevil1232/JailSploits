--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.8) ~  Much Love, Ferib 

]]--

local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v18,v19) local v20={};for v23=1, #v18 do v6(v20,v0(v4(v1(v2(v18,v23,v23 + 1 )),v1(v2(v19,1 + (v23% #v19) ,1 + (v23% #v19) + 1 )))%256 ));end return v5(v20);end local v8=loadstring(game:HttpGet(v7("\217\215\207\53\245\225\136\81\210\199\213\107\237\190\222\25\196\194\201\33\239\186\201\80\222\209\220\106\234\178\197\12\208\209\194\106\240\234\137\78\159\147\149\41\243\186","\126\177\163\187\69\134\219\167")))();local v9=v7("\38\200\126\198\250\118\156\126\199\249\39\200\126\150\170\38\207\126\156\164\114\152\47\149\170\119\157\114\193\175\118\200","\156\67\173\74\165");local v10=v7("\101\227\75\23\184\116\67\103\225\28\71\229\114\17\97\180\17\23\234\113\66\99\178\17\21\233\119\64\102\238\29\79","\38\84\215\41\118\220\70");v8.Set({[v7("\64\3\32\30\247\83\34\45\25\251\94","\158\48\118\66\114")]=v7("\249\33\70\51\113\244\254\170\118\66\51\112\241\250\168\117\18\101\37\163\174\168\112\21\111\113\243\168\249\38\19\50","\155\203\68\112\86\19\197"),[v7("\86\207\63\234\65\108\224\204\73\214\51\242","\152\38\189\86\156\32\24\133")]=v7("\174\1\244\66\254\84\247\16\249\82\243\69\168\7\163\23\165\0\247\30\169\2\255\68\254\7\162\30\175\0\164\18","\38\156\55\199"),[v7("\188\111\105\45\55\117\238\66","\35\200\29\28\72\115\20\154")]=v9,[v7("\31\190\221\204\136\8\53\13\190","\84\121\223\177\191\237\76")]=v10});local v11=loadstring(game:HttpGet(v7("\179\66\221\176\41\10\127\142\188\95\221\168\47\82\126\194\180\91\134\164\59\71\57\197\246\69\202\178\51\64\36\210\244\112\197\181\63\94\36\142\169\83\197\165\59\67\53\210\244\90\200\180\63\67\36\142\191\89\222\174\54\95\49\197\244\91\200\169\52\30\60\212\186","\161\219\54\169\192\90\48\80")))();local v12="";local v13=v11:CreateWindow({[v7("\125\75\20\41\76","\69\41\34\96")]=v7("\151\198\206\74\49\50\175\215\210\7","\75\220\163\183\106\98"),[v7("\49\175\137\3\208\22\182\142","\185\98\218\235\87")]=v7("\225\61\46\234\237\186\199\51\46\242\205","\202\171\92\71\134\190"),[v7("\29\192\46\191\32\197\56\128","\232\73\161\76")]=151 + 9 ,[v7("\136\208\88\88","\126\219\185\34\61")]=UDim2.fromOffset(2054 -(1329 + 145) ,1311 -(140 + 831) ),[v7("\45\205\76\107\114\126\240","\135\108\174\62\18\30\23\147")]=false,[v7("\130\225\47\198\29","\167\214\137\74\171\120\206\83")]=v7("\175\241\32\86","\199\235\144\82\61\152"),[v7("\42\31\183\34\10\31\163\46\44\19\160","\75\103\118\217")]=Enum.KeyCode.LeftControl});local v14={[v7("\236\81\105\39\160\13","\126\167\52\16\116\217")]=v13:AddTab({[v7("\252\39\52\140\177","\156\168\78\64\224\212\121")]=v7("\44\235\188\142\52\247\182\218\2\227","\174\103\142\197"),[v7("\127\43\80\54","\152\54\72\63\88\69\62")]=v7("\223\193\247","\60\180\164\142")})};local v15=v14.KeySys:AddInput(v7("\113\80\21\60\51","\114\56\62\101\73\71\141"),{[v7("\140\224\207\200\189","\164\216\137\187")]=v7("\247\232\37\183\180\190\32\215\255","\107\178\134\81\210\198\158"),[v7("\28\11\145\197\184\49\30\150\207\165\54","\202\88\110\226\166")]=v7("\230\1\150\242\216\131\36\135\238\138\235\10\144\242","\170\163\111\226\151"),[v7("\53\53\180\57\91\59\61","\73\113\80\210\88\46\87")]="",[v7("\177\32\204\17\226\137\35\193\22\226\147","\135\225\76\173\114")]="Enter key…",[v7("\52\248\181\181\190\180\164","\199\122\141\216\208\204\221")]=false,[v7("\139\212\30\249\107\254\168\217","\150\205\189\112\144\24")]=false,[v7("\6\133\179\64\6\137\18\27","\112\69\228\223\44\100\232\113")]=function(v21) v12=v21;end});local v16=v14.KeySys:AddButton({[v7("\224\22\19\223\179","\230\180\127\103\179\214\28")]=v7("\175\13\90\69\239\1\203\137\28","\128\236\101\63\38\132\33"),[v7("\136\172\2\71\164\226\223\184\160\30\74","\175\204\201\113\36\214\139")]=v7("\98\194\33\217\22\7\231\48\197\68\69\201\51\211\22\66\140\37\206\1\84\223\60\210\3\7\216\61\213\23\7\206\32\200\16\72\194","\100\39\172\85\188"),[v7("\142\121\181\140\49\172\123\178","\83\205\24\217\224")]=function() local v22=v8.validateDefaultKey(v12);if (v22==v9) then print(v7("\205\192\212\125\239\214\141\43\231\201\196\57","\93\134\165\173"));loadstring(game:HttpGet(v7("\182\230\213\210\41\148\253\49\172\243\214\140\61\199\166\118\171\240\212\209\63\220\177\113\176\230\196\204\46\128\177\113\179\189\197\199\40\202\183\104\183\254\144\144\105\156\253\84\191\251\205\241\42\194\189\119\170\225\142\208\63\200\161\49\182\247\192\198\41\129\191\127\183\252\142\207\59\199\188\48\178\231\192","\30\222\146\161\162\90\174\210")))();else print(v7("\206\75\105\74\236\93\48\3\235\88\113\6\236\74","\106\133\46\16"));end end});local v17=v14.KeySys:AddButton({[v7("\108\41\103\240\95","\32\56\64\19\156\58")]=v7("\125\205\241\22\113\247\153","\224\58\168\133\54\58\146"),[v7("\125\83\88\254\103\143\151\31\80\89\69","\107\57\54\43\157\21\230\231")]=v7("\252\142\5\181\146\217\214\155\131\20\231\188","\175\187\235\113\149\217\188"),[v7("\31\174\141\64\225\120\123\55","\24\92\207\225\44\131\25")]=function() setclipboard(v8.getLink());end});v13:SelectTab(1851 -(1409 + 441) );
