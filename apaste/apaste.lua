--CC AdmiPaste Download/uploader
--By Admicos

--dkjson MINIFIED
local a=true;local b=false;local c='json'local pairs,type,tostring,tonumber,getmetatable,setmetatable,rawset=pairs,type,tostring,tonumber,getmetatable,setmetatable,rawset;local error,require,pcall,select=error,require,pcall,select;local d,e=math.floor,math.huge;local f,g,h,i,j,k,l,m=string.rep,string.gsub,string.sub,string.byte,string.char,string.find,string.len,string.format;local n=string.match;local o=table.concat;local p={version="dkjson 2.5"}if b then _G[c]=p end;local q=nil;pcall(function()local r=require"debug".getmetatable;if r then getmetatable=r end end)p.null=setmetatable({},{__tojson=function()return"null"end})local function s(t)local u,v,w=0,0,0;for x,y in pairs(t)do if x=='n'and type(y)=='number'then w=y;if y>u then u=y end else if type(x)~='number'or x<1 or d(x)~=x then return false end;if x>u then u=x end;v=v+1 end end;if u>10 and u>w and u>v*2 then return false end;return true,u end;local z={["\""]="\\\"",["\\"]="\\\\",["\b"]="\\b",["\f"]="\\f",["\n"]="\\n",["\r"]="\\r",["\t"]="\\t"}local function A(B)local C=z[B]if C then return C end;local D,E,F,G=i(B,1,4)D,E,F,G=D or 0,E or 0,F or 0,G or 0;if D<=0x7f then C=D elseif 0xc0<=D and D<=0xdf and E>=0x80 then C=(D-0xc0)*0x40+E-0x80 elseif 0xe0<=D and D<=0xef and E>=0x80 and F>=0x80 then C=((D-0xe0)*0x40+E-0x80)*0x40+F-0x80 elseif 0xf0<=D and D<=0xf7 and E>=0x80 and F>=0x80 and G>=0x80 then C=(((D-0xf0)*0x40+E-0x80)*0x40+F-0x80)*0x40+G-0x80 else return""end;if C<=0xffff then return m("\\u%.4x",C)elseif C<=0x10ffff then C=C-0x10000;local H,I=0xD800+d(C/0x400),0xDC00+C%0x400;return m("\\u%.4x\\u%.4x",H,I)else return""end end;local function J(K,L,M)if k(K,L)then return g(K,L,M)else return K end end;local function N(C)C=J(C,"[%z\1-\31\"\\\127]",A)if k(C,"[\194\216\220\225\226\239]")then C=J(C,"\194[\128-\159\173]",A)C=J(C,"\216[\128-\132]",A)C=J(C,"\220\143",A)C=J(C,"\225\158[\180\181]",A)C=J(C,"\226\128[\140-\143\168-\175]",A)C=J(C,"\226\129[\160-\175]",A)C=J(C,"\239\187\191",A)C=J(C,"\239\191[\176-\191]",A)end;return"\""..C.."\""end;p.quotestring=N;local function O(K,P,v)local Q,R=k(K,P,1,true)if Q then return h(K,1,Q-1)..v..h(K,R+1,-1)else return K end end;local S,T;local function U()S=n(tostring(0.5),"([^05+])")T="[^0-9%-%+eE"..g(S,"[%^%$%(%)%%%.%[%]%*%+%-%?]","%%%0").."]+"end;U()local function V(W)return O(J(tostring(W),T,""),S,".")end;local function X(K)local W=tonumber(O(K,".",S))if not W then U()W=tonumber(O(K,".",S))end;return W end;local function Y(Z,_,a0)_[a0+1]="\n"_[a0+2]=f("  ",Z)a0=a0+2;return a0 end;function p.addnewline(a1)if a1.indent then a1.bufferlen=Y(a1.level or 0,a1.buffer,a1.bufferlen or#a1.buffer)end end;local a2;local function a3(a4,C,a5,a6,Z,_,a0,a7,a8,a1)local a9=type(a4)if a9~='string'and a9~='number'then return nil,"type '"..a9 .."' is not supported as a key by JSON."end;if a5 then a0=a0+1;_[a0]=","end;if a6 then a0=Y(Z,_,a0)end;_[a0+1]=N(a4)_[a0+2]=":"return a2(C,a6,Z,_,a0+2,a7,a8,a1)end;local function aa(ab,_,a1)local a0=a1.bufferlen;if type(ab)=='string'then a0=a0+1;_[a0]=ab end;return a0 end;local function ac(ad,C,a1,_,a0,ae)ae=ae or ad;local af=a1.exception;if not af then return nil,ae else a1.bufferlen=a0;local ag,ah=af(ad,C,a1,ae)if not ag then return nil,ah or ae end;return aa(ag,_,a1)end end;function p.encodeexception(ad,C,a1,ae)return N("<"..ae..">")end;a2=function(C,a6,Z,_,a0,a7,a8,a1)local ai=type(C)local aj=getmetatable(C)aj=type(aj)=='table'and aj;local ak=aj and aj.__tojson;if ak then if a7[C]then return ac('reference cycle',C,a1,_,a0)end;a7[C]=true;a1.bufferlen=a0;local ag,ah=ak(C,a1)if not ag then return ac('custom encoder failed',C,a1,_,a0,ah)end;a7[C]=nil;a0=aa(ag,_,a1)elseif C==nil then a0=a0+1;_[a0]="null"elseif ai=='number'then local al;if C~=C or C>=e or-C>=e then al="null"else al=V(C)end;a0=a0+1;_[a0]=al elseif ai=='boolean'then a0=a0+1;_[a0]=C and"true"or"false"elseif ai=='string'then a0=a0+1;_[a0]=N(C)elseif ai=='table'then if a7[C]then return ac('reference cycle',C,a1,_,a0)end;a7[C]=true;Z=Z+1;local am,v=s(C)if v==0 and aj and aj.__jsontype=='object'then am=false end;local ah;if am then a0=a0+1;_[a0]="["for Q=1,v do a0,ah=a2(C[Q],a6,Z,_,a0,a7,a8,a1)if not a0 then return nil,ah end;if Q<v then a0=a0+1;_[a0]=","end end;a0=a0+1;_[a0]="]"else local a5=false;a0=a0+1;_[a0]="{"local an=aj and aj.__jsonorder or a8;if an then local ao={}v=#an;for Q=1,v do local x=an[Q]local y=C[x]if y then ao[x]=true;a0,ah=a3(x,y,a5,a6,Z,_,a0,a7,a8,a1)a5=true end end;for x,y in pairs(C)do if not ao[x]then a0,ah=a3(x,y,a5,a6,Z,_,a0,a7,a8,a1)if not a0 then return nil,ah end;a5=true end end else for x,y in pairs(C)do a0,ah=a3(x,y,a5,a6,Z,_,a0,a7,a8,a1)if not a0 then return nil,ah end;a5=true end end;if a6 then a0=Y(Z-1,_,a0)end;a0=a0+1;_[a0]="}"end;a7[C]=nil else return ac('unsupported type',C,a1,_,a0,"type '"..ai.."' is not supported by JSON.")end;return a0 end;function p.encode(C,a1)a1=a1 or{}local ap=a1.buffer;local _=ap or{}a1.buffer=_;U()local ag,ah=a2(C,a1.indent,a1.level or 0,_,a1.bufferlen or 0,a1.tables or{},a1.keyorder,a1)if not ag then error(ah,2)elseif ap==_ then a1.bufferlen=ag;return true else a1.bufferlen=nil;a1.buffer=nil;return o(_)end end;local function aq(K,ar)local as,at,au=1,1,0;while true do at=k(K,"\n",at,true)if at and at<ar then as=as+1;au=at;at=at+1 else break end end;return"line "..as..", column "..ar-au end;local function av(K,aw,ar)return nil,l(K)+1,"unterminated "..aw.." at "..aq(K,ar)end;local function ax(K,at)while true do at=k(K,"%S",at)if not at then return nil end;local ay=h(K,at,at+1)if ay=="\239\187"and h(K,at+2,at+2)=="\191"then at=at+3 elseif ay=="//"then at=k(K,"[\n\r]",at+2)if not at then return nil end elseif ay=="/*"then at=k(K,"*/",at+2)if not at then return nil end;at=at+2 else return at end end end;local az={["\""]="\"",["\\"]="\\",["/"]="/",["b"]="\b",["f"]="\f",["n"]="\n",["r"]="\r",["t"]="\t"}local function aA(C)if C<0 then return nil elseif C<=0x007f then return j(C)elseif C<=0x07ff then return j(0xc0+d(C/0x40),0x80+d(C)%0x40)elseif C<=0xffff then return j(0xe0+d(C/0x1000),0x80+d(C/0x40)%0x40,0x80+d(C)%0x40)elseif C<=0x10ffff then return j(0xf0+d(C/0x40000),0x80+d(C/0x1000)%0x40,0x80+d(C/0x40)%0x40,0x80+d(C)%0x40)else return nil end end;local function aB(K,at)local aC=at+1;local _,v={},0;while true do local aD=k(K,"[\"\\]",aC)if not aD then return av(K,"string",at)end;if aD>aC then v=v+1;_[v]=h(K,aC,aD-1)end;if h(K,aD,aD)=="\""then aC=aD+1;break else local aE=h(K,aD+1,aD+1)local C;if aE=="u"then C=tonumber(h(K,aD+2,aD+5),16)if C then local aF;if 0xD800<=C and C<=0xDBff then if h(K,aD+6,aD+7)=="\\u"then aF=tonumber(h(K,aD+8,aD+11),16)if aF and 0xDC00<=aF and aF<=0xDFFF then C=(C-0xD800)*0x400+aF-0xDC00+0x10000 else aF=nil end end end;C=C and aA(C)if C then if aF then aC=aD+12 else aC=aD+6 end end end end;if not C then C=az[aE]or aE;aC=aD+2 end;v=v+1;_[v]=C end end;if v==1 then return _[1],aC elseif v>1 then return o(_),aC else return"",aC end end;local aG;local function aH(aw,aI,K,aJ,aK,aL,aM)local aN=l(K)local t,v={},0;local at=aJ+1;if aw=='object'then setmetatable(t,aL)else setmetatable(t,aM)end;while true do at=ax(K,at)if not at then return av(K,aw,aJ)end;local aO=h(K,at,at)if aO==aI then return t,at+1 end;local aP,aQ;aP,at,aQ=aG(K,at,aK,aL,aM)if aQ then return nil,at,aQ end;at=ax(K,at)if not at then return av(K,aw,aJ)end;aO=h(K,at,at)if aO==":"then if aP==nil then return nil,at,"cannot use nil as table index (at "..aq(K,at)..")"end;at=ax(K,at+1)if not at then return av(K,aw,aJ)end;local aR;aR,at,aQ=aG(K,at,aK,aL,aM)if aQ then return nil,at,aQ end;t[aP]=aR;at=ax(K,at)if not at then return av(K,aw,aJ)end;aO=h(K,at,at)else v=v+1;t[v]=aP end;if aO==","then at=at+1 end end end;aG=function(K,at,aK,aL,aM)at=at or 1;at=ax(K,at)if not at then return nil,l(K)+1,"no valid JSON value (reached the end)"end;local aO=h(K,at,at)if aO=="{"then return aH('object',"}",K,at,aK,aL,aM)elseif aO=="["then return aH('array',"]",K,at,aK,aL,aM)elseif aO=="\""then return aB(K,at)else local aS,aT=k(K,"^%-?[%d%.]+[eE]?[%+%-]?%d*",at)if aS then local aU=X(h(K,aS,aT))if aU then return aU,aT+1 end end;aS,aT=k(K,"^%a%w*",at)if aS then local aV=h(K,aS,aT)if aV=="true"then return true,aT+1 elseif aV=="false"then return false,aT+1 elseif aV=="null"then return aK,aT+1 end end;return nil,at,"no valid JSON value at "..aq(K,at)end end;local function aW(...)if select("#",...)>0 then return...else return{__jsontype='object'},{__jsontype='array'}end end;function p.decode(K,at,aK,...)local aL,aM=aW(...)return aG(K,at,aK,aL,aM)end;function p.use_lpeg()local aX=require("lpeg")if aX.version()=="0.11"then error"due to a bug in LPeg 0.11, it cannot be used for JSON matching"end;local aY=aX.match;local aZ,a_,b0=aX.P,aX.S,aX.R;local function b1(K,at,ah,a1)if not a1.msg then a1.msg=ah.." at "..aq(K,at)a1.pos=at end;return false end;local function b2(ah)return aX.Cmt(aX.Cc(ah)*aX.Carg(2),b1)end;local b3=aZ"//"*(1-a_"\n\r")^0;local b4=aZ"/*"*(1-aZ"*/")^0*aZ"*/"local b5=(a_" \n\r\t"+aZ"\239\187\191"+b3+b4)^0;local b6=1-a_"\"\\\n\r"local b7=aZ"\\"*aX.C(a_"\"\\/bfnrt"+b2"unsupported escape sequence")/az;local b8=b0("09","af","AF")local function b9(ba,at,bb,bc)bb,bc=tonumber(bb,16),tonumber(bc,16)if 0xD800<=bb and bb<=0xDBff and 0xDC00<=bc and bc<=0xDFFF then return true,aA((bb-0xD800)*0x400+bc-0xDC00+0x10000)else return false end end;local function bd(be)return aA(tonumber(be,16))end;local bf=aZ"\\u"*aX.C(b8*b8*b8*b8)local bg=aX.Cmt(bf*bf,b9)+bf/bd;local bh=bg+b7+b6;local bi=aZ"\""*aX.Cs(bh^0)*(aZ"\""+b2"unterminated string")local bj=aZ"-"^-1*(aZ"0"+b0"19"*b0"09"^0)local bk=aZ"."*b0"09"^0;local bl=a_"eE"*a_"+-"^-1*b0"09"^1;local bm=bj*bk^-1*bl^-1/X;local bn=aZ"true"*aX.Cc(true)+aZ"false"*aX.Cc(false)+aZ"null"*aX.Carg(1)local bo=bm+bi+bn;local bp,bq;local function br(K,at,aK,a1)local bs,bt;local bu;local bv,bw={},0;repeat bs,bt,bu=aY(bp,K,at,aK,a1)if not bu then break end;at=bu;bw=bw+1;bv[bw]=bs until bt=='last'return at,setmetatable(bv,a1.arraymeta)end;local function bx(K,at,aK,a1)local bs,a4,bt;local bu;local bv={}repeat a4,bs,bt,bu=aY(bq,K,at,aK,a1)if not bu then break end;at=bu;bv[a4]=bs until bt=='last'return at,setmetatable(bv,a1.objectmeta)end;local by=aZ"["*aX.Cmt(aX.Carg(1)*aX.Carg(2),br)*b5*(aZ"]"+b2"']' expected")local bz=aZ"{"*aX.Cmt(aX.Carg(1)*aX.Carg(2),bx)*b5*(aZ"}"+b2"'}' expected")local bA=b5*(by+bz+bo)local bB=bA+b5*b2"value expected"bp=bA*b5*(aZ","*aX.Cc'cont'+aX.Cc'last')*aX.Cp()local bC=aX.Cg(b5*bi*b5*(aZ":"+b2"colon expected")*bB)bq=bC*b5*(aZ","*aX.Cc'cont'+aX.Cc'last')*aX.Cp()local bD=bB*aX.Cp()function p.decode(K,at,aK,...)local a1={}a1.objectmeta,a1.arraymeta=aW(...)local bs,bE=aY(bD,K,at,aK,a1)if a1.msg then return nil,a1.pos,a1.msg else return bs,bE end end;p.use_lpeg=function()return p end;p.using_lpeg=true;return p end;if a then pcall(p.use_lpeg)end;
local json = p

--apaste
local args = { ... }
local host = "http://46.101.102.147:5000" --I won't use my domain name as SSL is enforced and CC doesn't like it.

local operation = {
	["get"] = function(paste, filename)
		if filename == nil then
			filename = paste
		end
		print("Getting paste: " .. paste)
		pasteJSON = http.get(host .. "/api/pastes/" .. paste)
			pasteJSONobj = json.decode(pasteJSON.readAll())

			if not pasteJSONobj.ok then
				pasteJSON.close()
				error("Cannot find paste " .. paste)
			end

			print("Paste creator: " .. pasteJSONobj.paste[1])
			pasteFile = fs.open(shell.resolve(filename), "w")
				pasteFile.write(pasteJSONobj.paste[2])
			pasteFile.close()
		pasteJSON.close()
		print("Saved paste to: " .. filename)
	end,
	["put"] = function(file, private)
		print("Putting file " .. file .. "...")

		pasteFile = fs.open(shell.resolve(file), "r")
			pasteJSON = http.post(host .. "/api/submit", "user=computercraft&" ..
														 "language=lua&" ..
														 "isBrowser=no&" ..
														 "paste=" .. textutils.urlEncode(pasteFile.readAll()))
				pasteJSONobj = json.decode(pasteJSON.readAll())

				if not pasteJSONobj.ok then
					pasteFile.close()
					pasteJSON.close()
					error("File couldn't be uploaded.")
				end

				print("Paste uploaded successfully!")
				print("Paste id: " .. pasteJSONobj.pasteid)

			pasteJSON.close()
		pasteFile.close()
	end,
	["n20"] = function()
	print("Getting newest 20...")
	pasteJSON = http.get(host .. "/api/pastes")
		pasteJSONobj = json.decode(pasteJSON.readAll())

		if not pasteJSONobj.ok then
			pasteJSON.close()
			error("How did you manage to do that?")
		end

		k = 1
		for i = 1, #pasteJSONobj.pastes do
			k = pasteJSONobj.pastes[i]

			print(k[1] .. " by " .. k[2] .. " (language: " .. k[3] .. ")")
		end
		k = nil
	pasteJSON.close()
	end
}

local function main()
--[[	if not os.loadAPI("json") then
		error("apaste requires the JSON api, get it from the link in the forum thread", 999)
	end
]]
	if #args >= 1 and #args < 4 then
		print("apaste 1.0.0 by Admicos")

		if operation[args[1]] then
			operation[args[1]](args[2], args[3])
		else
			print("No operation: " .. args[1])
		end
	else
		print([=[apaste 1.0.0 -- AdmiPaste client for CC

USAGE:
	apaste <get> <pasteid> <file>: get paste to file
	apaste <put> <file> <dont-list>: put paste online
	apaste <n20>: newest 20 pastes

	<dont-list>: if the paste should appear in the newest pastes
	(default: false)

	<file>: the filename of the saved paste
	(default: pasteid)]=])
	end
end main()
