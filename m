Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 0797671DCF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Oct 2017 03:39:43 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v9A3djGg012292
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 Oct 2017 20:39:45 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Mon, 9 Oct 2017 20:39:45 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 9 Oct 2017 20:31:40 -0700
Message-ID: <1effef47f6bd4d1acf687d64c628938b719de918.1507605334.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1507605334.git.David.Reyna@windriver.com>
References: <cover.1507605334.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/1] toaster: remove prettify
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 10 Oct 2017 03:39:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Reyna <David.Reyna@windriver.com>

Remove "prettify.js" and "prettify.css" due to license issues with Apache2.
Replace with "highlight.pack.js" with its BSD3 License.

[YOCTO #12206]

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Brian Avery <brian.avery@intel.com>
Signed-off-by: David Reyna <david.reyna@windriver.com>
---
 lib/toaster/toastergui/static/css/prettify.css     |  1 -
 lib/toaster/toastergui/static/js/highlight.pack.js |  2 ++
 lib/toaster/toastergui/static/js/libtoaster.js     |  6 ++---
 lib/toaster/toastergui/static/js/prettify.js       | 28 ------------------=
----
 lib/toaster/toastergui/templates/base.html         |  2 +-
 .../toastergui/templates/js-unit-tests.html        |  2 +-
 6 files changed, 6 insertions(+), 35 deletions(-)
 delete mode 100755 bitbake/lib/toaster/toastergui/static/css/prettify.css
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/highlight.pack=
.js
 delete mode 100755 bitbake/lib/toaster/toastergui/static/js/prettify.js

diff --git a/lib/toaster/toastergui/static/css/prettify.css b/lib/toaster/t=
oastergui/static/css/prettify.css
deleted file mode 100755
index b317a7c..0000000
--- a/lib/toaster/toastergui/static/css/prettify.css
+++ /dev/null
@@ -1 +0,0 @@
-.pln{color:#000}@media screen{.str{color:#080}.kwd{color:#008}.com{color:#=
800}.typ{color:#606}.lit{color:#066}.pun,.opn,.clo{color:#660}.tag{color:#0=
08}.atn{color:#606}.atv{color:#080}.dec,.var{color:#606}.fun{color:red}}@me=
dia print,projection{.str{color:#060}.kwd{color:#006;font-weight:bold}.com{=
color:#600;font-style:italic}.typ{color:#404;font-weight:bold}.lit{color:#0=
44}.pun,.opn,.clo{color:#440}.tag{color:#006;font-weight:bold}.atn{color:#4=
04}.atv{color:#060}}pre.prettyprint{padding:2px;border:1px solid #888}ol.li=
nenums{margin-top:0;margin-bottom:0}li.L0,li.L1,li.L2,li.L3,li.L5,li.L6,li.=
L7,li.L8{list-style-type:none}li.L1,li.L3,li.L5,li.L7,li.L9{background:#eee=
}
diff --git a/lib/toaster/toastergui/static/js/highlight.pack.js b/lib/toast=
er/toastergui/static/js/highlight.pack.js
new file mode 100644
index 0000000..8cc886f
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/highlight.pack.js
@@ -0,0 +1,2 @@
+/*! highlight.js v9.12.0 | BSD3 License | git.io/hljslicense */
+!function(e){var n=3D"object"=3D=3Dtypeof window&&window||"object"=3D=3Dty=
peof self&&self;"undefined"!=3Dtypeof exports?e(exports):n&&(n.hljs=3De({})=
,"function"=3D=3Dtypeof define&&define.amd&&define([],function(){return n.h=
ljs}))}(function(e){function n(e){return e.replace(/&/g,"&amp;").replace(/<=
/g,"&lt;").replace(/>/g,"&gt;")}function t(e){return e.nodeName.toLowerCase=
()}function r(e,n){var t=3De&&e.exec(n);return t&&0=3D=3D=3Dt.index}functio=
n a(e){return k.test(e)}function i(e){var n,t,r,i,o=3De.className+" ";if(o+=
=3De.parentNode?e.parentNode.className:"",t=3DB.exec(o))return w(t[1])?t[1]=
:"no-highlight";for(o=3Do.split(/\s+/),n=3D0,r=3Do.length;r>n;n++)if(i=3Do[=
n],a(i)||w(i))return i}function o(e){var n,t=3D{},r=3DArray.prototype.slice=
.call(arguments,1);for(n in e)t[n]=3De[n];return r.forEach(function(e){for(=
n in e)t[n]=3De[n]}),t}function u(e){var n=3D[];return function r(e,a){for(=
var i=3De.firstChild;i;i=3Di.nextSibling)3=3D=3D=3Di.nodeType?a+=3Di.nodeVa=
lue.length:1=3D=3D=3Di.nodeType&&(n.push({event:"start",offset:a,node:i}),a=
=3Dr(i,a),t(i).match(/br|hr|img|input/)||n.push({event:"stop",offset:a,node=
:i}));return a}(e,0),n}function c(e,r,a){function i(){return e.length&&r.le=
ngth?e[0].offset!=3D=3Dr[0].offset?e[0].offset<r[0].offset?e:r:"start"=3D=
=3D=3Dr[0].event?e:r:e.length?e:r}function o(e){function r(e){return" "+e.n=
odeName+'=3D"'+n(e.value).replace('"',"&quot;")+'"'}s+=3D"<"+t(e)+E.map.cal=
l(e.attributes,r).join("")+">"}function u(e){s+=3D"</"+t(e)+">"}function c(=
e){("start"=3D=3D=3De.event?o:u)(e.node)}for(var l=3D0,s=3D"",f=3D[];e.leng=
th||r.length;){var g=3Di();if(s+=3Dn(a.substring(l,g[0].offset)),l=3Dg[0].o=
ffset,g=3D=3D=3De){f.reverse().forEach(u);do c(g.splice(0,1)[0]),g=3Di();wh=
ile(g=3D=3D=3De&&g.length&&g[0].offset=3D=3D=3Dl);f.reverse().forEach(o)}el=
se"start"=3D=3D=3Dg[0].event?f.push(g[0].node):f.pop(),c(g.splice(0,1)[0])}=
return s+n(a.substr(l))}function l(e){return e.v&&!e.cached_variants&&(e.ca=
ched_variants=3De.v.map(function(n){return o(e,{v:null},n)})),e.cached_vari=
ants||e.eW&&[o(e)]||[e]}function s(e){function n(e){return e&&e.source||e}f=
unction t(t,r){return new RegExp(n(t),"m"+(e.cI?"i":"")+(r?"g":""))}functio=
n r(a,i){if(!a.compiled){if(a.compiled=3D!0,a.k=3Da.k||a.bK,a.k){var o=3D{}=
,u=3Dfunction(n,t){e.cI&&(t=3Dt.toLowerCase()),t.split(" ").forEach(functio=
n(e){var t=3De.split("|");o[t[0]]=3D[n,t[1]?Number(t[1]):1]})};"string"=3D=
=3Dtypeof a.k?u("keyword",a.k):x(a.k).forEach(function(e){u(e,a.k[e])}),a.k=
=3Do}a.lR=3Dt(a.l||/\w+/,!0),i&&(a.bK&&(a.b=3D"\\b("+a.bK.split(" ").join("=
|")+")\\b"),a.b||(a.b=3D/\B|\b/),a.bR=3Dt(a.b),a.e||a.eW||(a.e=3D/\B|\b/),a=
.e&&(a.eR=3Dt(a.e)),a.tE=3Dn(a.e)||"",a.eW&&i.tE&&(a.tE+=3D(a.e?"|":"")+i.t=
E)),a.i&&(a.iR=3Dt(a.i)),null=3D=3Da.r&&(a.r=3D1),a.c||(a.c=3D[]),a.c=3DArr=
ay.prototype.concat.apply([],a.c.map(function(e){return l("self"=3D=3D=3De?=
a:e)})),a.c.forEach(function(e){r(e,a)}),a.starts&&r(a.starts,i);var c=3Da.=
c.map(function(e){return e.bK?"\\.?("+e.b+")\\.?":e.b}).concat([a.tE,a.i]).=
map(n).filter(Boolean);a.t=3Dc.length?t(c.join("|"),!0):{exec:function(){re=
turn null}}}}r(e)}function f(e,t,a,i){function o(e,n){var t,a;for(t=3D0,a=
=3Dn.c.length;a>t;t++)if(r(n.c[t].bR,e))return n.c[t]}function u(e,n){if(r(=
e.eR,n)){for(;e.endsParent&&e.parent;)e=3De.parent;return e}return e.eW?u(e=
.parent,n):void 0}function c(e,n){return!a&&r(n.iR,e)}function l(e,n){var t=
=3DN.cI?n[0].toLowerCase():n[0];return e.k.hasOwnProperty(t)&&e.k[t]}functi=
on p(e,n,t,r){var a=3Dr?"":I.classPrefix,i=3D'<span class=3D"'+a,o=3Dt?"":C=
;return i+=3De+'">',i+n+o}function h(){var e,t,r,a;if(!E.k)return n(k);for(=
a=3D"",t=3D0,E.lR.lastIndex=3D0,r=3DE.lR.exec(k);r;)a+=3Dn(k.substring(t,r.=
index)),e=3Dl(E,r),e?(B+=3De[1],a+=3Dp(e[0],n(r[0]))):a+=3Dn(r[0]),t=3DE.lR=
.lastIndex,r=3DE.lR.exec(k);return a+n(k.substr(t))}function d(){var e=3D"s=
tring"=3D=3Dtypeof E.sL;if(e&&!y[E.sL])return n(k);var t=3De?f(E.sL,k,!0,x[=
E.sL]):g(k,E.sL.length?E.sL:void 0);return E.r>0&&(B+=3Dt.r),e&&(x[E.sL]=3D=
t.top),p(t.language,t.value,!1,!0)}function b(){L+=3Dnull!=3DE.sL?d():h(),k=
=3D""}function v(e){L+=3De.cN?p(e.cN,"",!0):"",E=3DObject.create(e,{parent:=
{value:E}})}function m(e,n){if(k+=3De,null=3D=3Dn)return b(),0;var t=3Do(n,=
E);if(t)return t.skip?k+=3Dn:(t.eB&&(k+=3Dn),b(),t.rB||t.eB||(k=3Dn)),v(t,n=
),t.rB?0:n.length;var r=3Du(E,n);if(r){var a=3DE;a.skip?k+=3Dn:(a.rE||a.eE|=
|(k+=3Dn),b(),a.eE&&(k=3Dn));do E.cN&&(L+=3DC),E.skip||(B+=3DE.r),E=3DE.par=
ent;while(E!=3D=3Dr.parent);return r.starts&&v(r.starts,""),a.rE?0:n.length=
}if(c(n,E))throw new Error('Illegal lexeme "'+n+'" for mode "'+(E.cN||"<unn=
amed>")+'"');return k+=3Dn,n.length||1}var N=3Dw(e);if(!N)throw new Error('=
Unknown language: "'+e+'"');s(N);var R,E=3Di||N,x=3D{},L=3D"";for(R=3DE;R!=
=3D=3DN;R=3DR.parent)R.cN&&(L=3Dp(R.cN,"",!0)+L);var k=3D"",B=3D0;try{for(v=
ar M,j,O=3D0;;){if(E.t.lastIndex=3DO,M=3DE.t.exec(t),!M)break;j=3Dm(t.subst=
ring(O,M.index),M[0]),O=3DM.index+j}for(m(t.substr(O)),R=3DE;R.parent;R=3DR=
.parent)R.cN&&(L+=3DC);return{r:B,value:L,language:e,top:E}}catch(T){if(T.m=
essage&&-1!=3D=3DT.message.indexOf("Illegal"))return{r:0,value:n(t)};throw =
T}}function g(e,t){t=3Dt||I.languages||x(y);var r=3D{r:0,value:n(e)},a=3Dr;=
return t.filter(w).forEach(function(n){var t=3Df(n,e,!1);t.language=3Dn,t.r=
>a.r&&(a=3Dt),t.r>r.r&&(a=3Dr,r=3Dt)}),a.language&&(r.second_best=3Da),r}fu=
nction p(e){return I.tabReplace||I.useBR?e.replace(M,function(e,n){return I=
.useBR&&"\n"=3D=3D=3De?"<br>":I.tabReplace?n.replace(/\t/g,I.tabReplace):""=
}):e}function h(e,n,t){var r=3Dn?L[n]:t,a=3D[e.trim()];return e.match(/\bhl=
js\b/)||a.push("hljs"),-1=3D=3D=3De.indexOf(r)&&a.push(r),a.join(" ").trim(=
)}function d(e){var n,t,r,o,l,s=3Di(e);a(s)||(I.useBR?(n=3Ddocument.createE=
lementNS("http://www.w3.org/1999/xhtml","div"),n.innerHTML=3De.innerHTML.re=
place(/\n/g,"").replace(/<br[ \/]*>/g,"\n")):n=3De,l=3Dn.textContent,r=3Ds?=
f(s,l,!0):g(l),t=3Du(n),t.length&&(o=3Ddocument.createElementNS("http://www=
.w3.org/1999/xhtml","div"),o.innerHTML=3Dr.value,r.value=3Dc(t,u(o),l)),r.v=
alue=3Dp(r.value),e.innerHTML=3Dr.value,e.className=3Dh(e.className,s,r.lan=
guage),e.result=3D{language:r.language,re:r.r},r.second_best&&(e.second_bes=
t=3D{language:r.second_best.language,re:r.second_best.r}))}function b(e){I=
=3Do(I,e)}function v(){if(!v.called){v.called=3D!0;var e=3Ddocument.querySe=
lectorAll("pre code");E.forEach.call(e,d)}}function m(){addEventListener("D=
OMContentLoaded",v,!1),addEventListener("load",v,!1)}function N(n,t){var r=
=3Dy[n]=3Dt(e);r.aliases&&r.aliases.forEach(function(e){L[e]=3Dn})}function=
 R(){return x(y)}function w(e){return e=3D(e||"").toLowerCase(),y[e]||y[L[e=
]]}var E=3D[],x=3DObject.keys,y=3D{},L=3D{},k=3D/^(no-?highlight|plain|text=
)$/i,B=3D/\blang(?:uage)?-([\w-]+)\b/i,M=3D/((^(<[^>]+>|\t|)+|(?:\n)))/gm,C=
=3D"</span>",I=3D{classPrefix:"hljs-",tabReplace:null,useBR:!1,languages:vo=
id 0};return e.highlight=3Df,e.highlightAuto=3Dg,e.fixMarkup=3Dp,e.highligh=
tBlock=3Dd,e.configure=3Db,e.initHighlighting=3Dv,e.initHighlightingOnLoad=
=3Dm,e.registerLanguage=3DN,e.listLanguages=3DR,e.getLanguage=3Dw,e.inherit=
=3Do,e.IR=3D"[a-zA-Z]\\w*",e.UIR=3D"[a-zA-Z_]\\w*",e.NR=3D"\\b\\d+(\\.\\d+)=
?",e.CNR=3D"(-?)(\\b0[xX][a-fA-F0-9]+|(\\b\\d+(\\.\\d*)?|\\.\\d+)([eE][-+]?=
\\d+)?)",e.BNR=3D"\\b(0b[01]+)",e.RSR=3D"!|!=3D|!=3D=3D|%|%=3D|&|&&|&=3D|\\=
*|\\*=3D|\\+|\\+=3D|,|-|-=3D|/=3D|/|:|;|<<|<<=3D|<=3D|<|=3D=3D=3D|=3D=3D|=
=3D|>>>=3D|>>=3D|>=3D|>>>|>>|>|\\?|\\[|\\{|\\(|\\^|\\^=3D|\\||\\|=3D|\\|\\|=
|~",e.BE=3D{b:"\\\\[\\s\\S]",r:0},e.ASM=3D{cN:"string",b:"'",e:"'",i:"\\n",=
c:[e.BE]},e.QSM=3D{cN:"string",b:'"',e:'"',i:"\\n",c:[e.BE]},e.PWM=3D{b:/\b=
(a|an|the|are|I'm|isn't|don't|doesn't|won't|but|just|should|pretty|simply|e=
nough|gonna|going|wtf|so|such|will|you|your|they|like|more)\b/},e.C=3Dfunct=
ion(n,t,r){var a=3De.inherit({cN:"comment",b:n,e:t,c:[]},r||{});return a.c.=
push(e.PWM),a.c.push({cN:"doctag",b:"(?:TODO|FIXME|NOTE|BUG|XXX):",r:0}),a}=
,e.CLCM=3De.C("//","$"),e.CBCM=3De.C("/\\*","\\*/"),e.HCM=3De.C("#","$"),e.=
NM=3D{cN:"number",b:e.NR,r:0},e.CNM=3D{cN:"number",b:e.CNR,r:0},e.BNM=3D{cN=
:"number",b:e.BNR,r:0},e.CSSNM=3D{cN:"number",b:e.NR+"(%|em|ex|ch|rem|vw|vh=
|vmin|vmax|cm|mm|in|pt|pc|px|deg|grad|rad|turn|s|ms|Hz|kHz|dpi|dpcm|dppx)?"=
,r:0},e.RM=3D{cN:"regexp",b:/\//,e:/\/[gimuy]*/,i:/\n/,c:[e.BE,{b:/\[/,e:/\=
]/,r:0,c:[e.BE]}]},e.TM=3D{cN:"title",b:e.IR,r:0},e.UTM=3D{cN:"title",b:e.U=
IR,r:0},e.METHOD_GUARD=3D{b:"\\.\\s*"+e.UIR,r:0},e});hljs.registerLanguage(=
"sql",function(e){var t=3De.C("--","$");return{cI:!0,i:/[<>{}*#]/,c:[{bK:"b=
egin end start commit rollback savepoint lock alter create drop rename call=
 delete do handler insert load replace select truncate update set show prag=
ma grant merge describe use explain help declare prepare execute deallocate=
 release unlock purge reset change stop analyze cache flush optimize repair=
 kill install uninstall checksum restore check backup revoke comment",e:/;/=
,eW:!0,l:/[\w\.]+/,k:{keyword:"abort abs absolute acc acce accep accept acc=
ess accessed accessible account acos action activate add addtime admin admi=
nister advanced advise aes_decrypt aes_encrypt after agent aggregate ali al=
ia alias allocate allow alter always analyze ancillary and any anydata anyd=
ataset anyschema anytype apply archive archived archivelog are as asc ascii=
 asin assembly assertion associate asynchronous at atan atn2 attr attri att=
rib attribu attribut attribute attributes audit authenticated authenticatio=
n authid authors auto autoallocate autodblink autoextend automatic availabi=
lity avg backup badfile basicfile before begin beginning benchmark between =
bfile bfile_base big bigfile bin binary_double binary_float binlog bit_and =
bit_count bit_length bit_or bit_xor bitmap blob_base block blocksize body b=
oth bound buffer_cache buffer_pool build bulk by byte byteordermark bytes c=
ache caching call calling cancel capacity cascade cascaded case cast catalo=
g category ceil ceiling chain change changed char_base char_length characte=
r_length characters characterset charindex charset charsetform charsetid ch=
eck checksum checksum_agg child choose chr chunk class cleanup clear client=
 clob clob_base clone close cluster_id cluster_probability cluster_set clus=
tering coalesce coercibility col collate collation collect colu colum colum=
n column_value columns columns_updated comment commit compact compatibility=
 compiled complete composite_limit compound compress compute concat concat_=
ws concurrent confirm conn connec connect connect_by_iscycle connect_by_isl=
eaf connect_by_root connect_time connection consider consistent constant co=
nstraint constraints constructor container content contents context contrib=
utors controlfile conv convert convert_tz corr corr_k corr_s corresponding =
corruption cos cost count count_big counted covar_pop covar_samp cpu_per_ca=
ll cpu_per_session crc32 create creation critical cross cube cume_dist curd=
ate current current_date current_time current_timestamp current_user cursor=
 curtime customdatum cycle data database databases datafile datafiles datal=
ength date_add date_cache date_format date_sub dateadd datediff datefrompar=
ts datename datepart datetime2fromparts day day_to_second dayname dayofmont=
h dayofweek dayofyear days db_role_change dbtimezone ddl deallocate declare=
 decode decompose decrement decrypt deduplicate def defa defau defaul defau=
lt defaults deferred defi defin define degrees delayed delegate delete dele=
te_all delimited demand dense_rank depth dequeue des_decrypt des_encrypt de=
s_key_file desc descr descri describ describe descriptor deterministic diag=
nostics difference dimension direct_load directory disable disable_all disa=
llow disassociate discardfile disconnect diskgroup distinct distinctrow dis=
tribute distributed div do document domain dotnet double downgrade drop dum=
pfile duplicate duration each edition editionable editions element ellipsis=
 else elsif elt empty enable enable_all enclosed encode encoding encrypt en=
d end-exec endian enforced engine engines enqueue enterprise entityescaping=
 eomonth error errors escaped evalname evaluate event eventdata events exce=
pt exception exceptions exchange exclude excluding execu execut execute exe=
mpt exists exit exp expire explain export export_set extended extent extern=
al external_1 external_2 externally extract failed failed_login_attempts fa=
ilover failure far fast feature_set feature_value fetch field fields file f=
ile_name_convert filesystem_like_logging final finish first first_value fix=
ed flash_cache flashback floor flush following follows for forall force for=
m forma format found found_rows freelist freelists freepools fresh from fro=
m_base64 from_days ftp full function general generated get get_format get_l=
ock getdate getutcdate global global_name globally go goto grant grants gre=
atest group group_concat group_id grouping grouping_id groups gtid_subtract=
 guarantee guard handler hash hashkeys having hea head headi headin heading=
 heap help hex hierarchy high high_priority hosts hour http id ident_curren=
t ident_incr ident_seed identified identity idle_time if ifnull ignore iif =
ilike ilm immediate import in include including increment index indexes ind=
exing indextype indicator indices inet6_aton inet6_ntoa inet_aton inet_ntoa=
 infile initial initialized initially initrans inmemory inner innodb input =
insert install instance instantiable instr interface interleaved intersect =
into invalidate invisible is is_free_lock is_ipv4 is_ipv4_compat is_not is_=
not_null is_used_lock isdate isnull isolation iterate java join json json_e=
xists keep keep_duplicates key keys kill language large last last_day last_=
insert_id last_value lax lcase lead leading least leaves left len lenght le=
ngth less level levels library like like2 like4 likec limit lines link list=
 listagg little ln load load_file lob lobs local localtime localtimestamp l=
ocate locator lock locked log log10 log2 logfile logfiles logging logical l=
ogical_reads_per_call logoff logon logs long loop low low_priority lower lp=
ad lrtrim ltrim main make_set makedate maketime managed management manual m=
ap mapping mask master master_pos_wait match matched materialized max maxex=
tents maximize maxinstances maxlen maxlogfiles maxloghistory maxlogmembers =
maxsize maxtrans md5 measures median medium member memcompress memory merge=
 microsecond mid migration min minextents minimum mining minus minute minva=
lue missing mod mode model modification modify module monitoring month mont=
hs mount move movement multiset mutex name name_const names nan national na=
tive natural nav nchar nclob nested never new newline next nextval no no_wr=
ite_to_binlog noarchivelog noaudit nobadfile nocheck nocompress nocopy nocy=
cle nodelay nodiscardfile noentityescaping noguarantee nokeep nologfile nom=
apping nomaxvalue nominimize nominvalue nomonitoring none noneditionable no=
nschema noorder nopr nopro noprom nopromp noprompt norely noresetlogs norev=
erse normal norowdependencies noschemacheck noswitch not nothing notice not=
rim novalidate now nowait nth_value nullif nulls num numb numbe nvarchar nv=
archar2 object ocicoll ocidate ocidatetime ociduration ociinterval ociloblo=
cator ocinumber ociref ocirefcursor ocirowid ocistring ocitype oct octet_le=
ngth of off offline offset oid oidindex old on online only opaque open oper=
ations operator optimal optimize option optionally or oracle oracle_date or=
adata ord ordaudio orddicom orddoc order ordimage ordinality ordvideo organ=
ization orlany orlvary out outer outfile outline output over overflow overr=
iding package pad parallel parallel_enable parameters parent parse partial =
partition partitions pascal passing password password_grace_time password_l=
ock_time password_reuse_max password_reuse_time password_verify_function pa=
tch path patindex pctincrease pctthreshold pctused pctversion percent perce=
nt_rank percentile_cont percentile_disc performance period period_add perio=
d_diff permanent physical pi pipe pipelined pivot pluggable plugin policy p=
osition post_transaction pow power pragma prebuilt precedes preceding preci=
sion prediction prediction_cost prediction_details prediction_probability p=
rediction_set prepare present preserve prior priority private private_sga p=
rivileges procedural procedure procedure_analyze processlist profiles proje=
ct prompt protection public publishingservername purge quarter query quick =
quiesce quota quotename radians raise rand range rank raw read reads readsi=
ze rebuild record records recover recovery recursive recycle redo reduced r=
ef reference referenced references referencing refresh regexp_like register=
 regr_avgx regr_avgy regr_count regr_intercept regr_r2 regr_slope regr_sxx =
regr_sxy reject rekey relational relative relaylog release release_lock rel=
ies_on relocate rely rem remainder rename repair repeat replace replicate r=
eplication required reset resetlogs resize resource respect restore restric=
ted result result_cache resumable resume retention return returning returns=
 reuse reverse revoke right rlike role roles rollback rolling rollup round =
row row_count rowdependencies rowid rownum rows rtrim rules safe salt sampl=
e save savepoint sb1 sb2 sb4 scan schema schemacheck scn scope scroll sdo_g=
eoraster sdo_topo_geometry search sec_to_time second section securefile sec=
urity seed segment select self sequence sequential serializable server serv=
ererror session session_user sessions_per_user set sets settings sha sha1 s=
ha2 share shared shared_pool short show shrink shutdown si_averagecolor si_=
colorhistogram si_featurelist si_positionalcolor si_stillimage si_texture s=
iblings sid sign sin size size_t sizes skip slave sleep smalldatetimefrompa=
rts smallfile snapshot some soname sort soundex source space sparse spfile =
split sql sql_big_result sql_buffer_result sql_cache sql_calc_found_rows sq=
l_small_result sql_variant_property sqlcode sqldata sqlerror sqlname sqlsta=
te sqrt square standalone standby start starting startup statement static s=
tatistics stats_binomial_test stats_crosstab stats_ks_test stats_mode stats=
_mw_test stats_one_way_anova stats_t_test_ stats_t_test_indep stats_t_test_=
one stats_t_test_paired stats_wsr_test status std stddev stddev_pop stddev_=
samp stdev stop storage store stored str str_to_date straight_join strcmp s=
trict string struct stuff style subdate subpartition subpartitions substitu=
table substr substring subtime subtring_index subtype success sum suspend s=
witch switchoffset switchover sync synchronous synonym sys sys_xmlagg sysas=
m sysaux sysdate sysdatetimeoffset sysdba sysoper system system_user sysutc=
datetime table tables tablespace tan tdo template temporary terminated tert=
iary_weights test than then thread through tier ties time time_format time_=
zone timediff timefromparts timeout timestamp timestampadd timestampdiff ti=
mezone_abbr timezone_minute timezone_region to to_base64 to_date to_days to=
_seconds todatetimeoffset trace tracking transaction transactional translat=
e translation treat trigger trigger_nestlevel triggers trim truncate try_ca=
st try_convert try_parse type ub1 ub2 ub4 ucase unarchived unbounded uncomp=
ress under undo unhex unicode uniform uninstall union unique unix_timestamp=
 unknown unlimited unlock unpivot unrecoverable unsafe unsigned until untru=
sted unusable unused update updated upgrade upped upper upsert url urowid u=
sable usage use use_stored_outlines user user_data user_resources users usi=
ng utc_date utc_timestamp uuid uuid_short validate validate_password_streng=
th validation valist value values var var_samp varcharc vari varia variab v=
ariabl variable variables variance varp varraw varrawc varray verify versio=
n versions view virtual visible void wait wallet warning warnings week week=
day weekofyear wellformed when whene whenev wheneve whenever where while wh=
itespace with within without work wrapped xdb xml xmlagg xmlattributes xmlc=
ast xmlcolattval xmlelement xmlexists xmlforest xmlindex xmlnamespaces xmlp=
i xmlquery xmlroot xmlschema xmlserialize xmltable xmltype xor year year_to=
_month years yearweek",literal:"true false null",built_in:"array bigint bin=
ary bit blob boolean char character date dec decimal float int int8 integer=
 interval number numeric real record serial serial8 smallint text varchar v=
arying void"},c:[{cN:"string",b:"'",e:"'",c:[e.BE,{b:"''"}]},{cN:"string",b=
:'"',e:'"',c:[e.BE,{b:'""'}]},{cN:"string",b:"`",e:"`",c:[e.BE]},e.CNM,e.CB=
CM,t]},e.CBCM,t]}});hljs.registerLanguage("perl",function(e){var t=3D"getpw=
ent getservent quotemeta msgrcv scalar kill dbmclose undef lc ma syswrite t=
r send umask sysopen shmwrite vec qx utime local oct semctl localtime readp=
ipe do return format read sprintf dbmopen pop getpgrp not getpwnam rewinddi=
r qqfileno qw endprotoent wait sethostent bless s|0 opendir continue each s=
leep endgrent shutdown dump chomp connect getsockname die socketpair close =
flock exists index shmgetsub for endpwent redo lstat msgctl setpgrp abs exi=
t select print ref gethostbyaddr unshift fcntl syscall goto getnetbyaddr jo=
in gmtime symlink semget splice x|0 getpeername recv log setsockopt cos las=
t reverse gethostbyname getgrnam study formline endhostent times chop lengt=
h gethostent getnetent pack getprotoent getservbyname rand mkdir pos chmod =
y|0 substr endnetent printf next open msgsnd readdir use unlink getsockopt =
getpriority rindex wantarray hex system getservbyport endservent int chr un=
tie rmdir prototype tell listen fork shmread ucfirst setprotoent else sysse=
ek link getgrgid shmctl waitpid unpack getnetbyname reset chdir grep split =
require caller lcfirst until warn while values shift telldir getpwuid my ge=
tprotobynumber delete and sort uc defined srand accept package seekdir getp=
rotobyname semop our rename seek if q|0 chroot sysread setpwent no crypt ge=
tc chown sqrt write setnetent setpriority foreach tie sin msgget map stat g=
etlogin unless elsif truncate exec keys glob tied closedirioctl socket read=
link eval xor readline binmode setservent eof ord bind alarm pipe atan2 get=
grent exp time push setgrent gt lt or ne m|0 break given say state when",r=
=3D{cN:"subst",b:"[$@]\\{",e:"\\}",k:t},s=3D{b:"->{",e:"}"},n=3D{v:[{b:/\$\=
d/},{b:/[\$%@](\^\w\b|#\w+(::\w+)*|{\w+}|\w+(::\w*)*)/},{b:/[\$%@][^\s\w{]/=
,r:0}]},i=3D[e.BE,r,n],o=3D[n,e.HCM,e.C("^\\=3D\\w","\\=3Dcut",{eW:!0}),s,{=
cN:"string",c:i,v:[{b:"q[qwxr]?\\s*\\(",e:"\\)",r:5},{b:"q[qwxr]?\\s*\\[",e=
:"\\]",r:5},{b:"q[qwxr]?\\s*\\{",e:"\\}",r:5},{b:"q[qwxr]?\\s*\\|",e:"\\|",=
r:5},{b:"q[qwxr]?\\s*\\<",e:"\\>",r:5},{b:"qw\\s+q",e:"q",r:5},{b:"'",e:"'"=
,c:[e.BE]},{b:'"',e:'"'},{b:"`",e:"`",c:[e.BE]},{b:"{\\w+}",c:[],r:0},{b:"-=
?\\w+\\s*\\=3D\\>",c:[],r:0}]},{cN:"number",b:"(\\b0[0-7_]+)|(\\b0x[0-9a-fA=
-F_]+)|(\\b[1-9][0-9_]*(\\.[0-9_]+)?)|[0_]\\b",r:0},{b:"(\\/\\/|"+e.RSR+"|\=
\b(split|return|print|reverse|grep)\\b)\\s*",k:"split return print reverse =
grep",r:0,c:[e.HCM,{cN:"regexp",b:"(s|tr|y)/(\\\\.|[^/])*/(\\\\.|[^/])*/[a-=
z]*",r:10},{cN:"regexp",b:"(m|qr)?/",e:"/[a-z]*",c:[e.BE],r:0}]},{cN:"funct=
ion",bK:"sub",e:"(\\s*\\(.*?\\))?[;{]",eE:!0,r:5,c:[e.TM]},{b:"-\\w\\b",r:0=
},{b:"^__DATA__$",e:"^__END__$",sL:"mojolicious",c:[{b:"^@@.*",e:"$",cN:"co=
mment"}]}];return r.c=3Do,s.c=3Do,{aliases:["pl","pm"],l:/[\w\.]+/,k:t,c:o}=
});hljs.registerLanguage("ini",function(e){var b=3D{cN:"string",c:[e.BE],v:=
[{b:"'''",e:"'''",r:10},{b:'"""',e:'"""',r:10},{b:'"',e:'"'},{b:"'",e:"'"}]=
};return{aliases:["toml"],cI:!0,i:/\S/,c:[e.C(";","$"),e.HCM,{cN:"section",=
b:/^\s*\[+/,e:/\]+/},{b:/^[a-z0-9\[\]_-]+\s*=3D\s*/,e:"$",rB:!0,c:[{cN:"att=
r",b:/[a-z0-9\[\]_-]+/},{b:/=3D/,eW:!0,r:0,c:[{cN:"literal",b:/\bon|off|tru=
e|false|yes|no\b/},{cN:"variable",v:[{b:/\$[\w\d"][\w\d_]*/},{b:/\$\{(.*?)}=
/}]},b,{cN:"number",b:/([\+\-]+)?[\d]+_[\d_]+/},e.NM]}]}]}});hljs.registerL=
anguage("diff",function(e){return{aliases:["patch"],c:[{cN:"meta",r:10,v:[{=
b:/^@@ +\-\d+,\d+ +\+\d+,\d+ +@@$/},{b:/^\*\*\* +\d+,\d+ +\*\*\*\*$/},{b:/^=
\-\-\- +\d+,\d+ +\-\-\-\-$/}]},{cN:"comment",v:[{b:/Index: /,e:/$/},{b:/=3D=
{3,}/,e:/$/},{b:/^\-{3}/,e:/$/},{b:/^\*{3} /,e:/$/},{b:/^\+{3}/,e:/$/},{b:/=
\*{5}/,e:/\*{5}$/}]},{cN:"addition",b:"^\\+",e:"$"},{cN:"deletion",b:"^\\-"=
,e:"$"},{cN:"addition",b:"^\\!",e:"$"}]}});hljs.registerLanguage("bash",fun=
ction(e){var t=3D{cN:"variable",v:[{b:/\$[\w\d#@][\w\d_]*/},{b:/\$\{(.*?)}/=
}]},s=3D{cN:"string",b:/"/,e:/"/,c:[e.BE,t,{cN:"variable",b:/\$\(/,e:/\)/,c=
:[e.BE]}]},a=3D{cN:"string",b:/'/,e:/'/};return{aliases:["sh","zsh"],l:/\b-=
?[a-z\._]+\b/,k:{keyword:"if then else elif fi for while in do done case es=
ac function",literal:"true false",built_in:"break cd continue eval exec exi=
t export getopts hash pwd readonly return shift test times trap umask unset=
 alias bind builtin caller command declare echo enable help let local logou=
t mapfile printf read readarray source type typeset ulimit unalias set shop=
t autoload bg bindkey bye cap chdir clone comparguments compcall compctl co=
mpdescribe compfiles compgroups compquote comptags comptry compvalues dirs =
disable disown echotc echoti emulate fc fg float functions getcap getln his=
tory integer jobs kill limit log noglob popd print pushd pushln rehash sche=
d setcap setopt stat suspend ttyctl unfunction unhash unlimit unsetopt vare=
d wait whence where which zcompile zformat zftp zle zmodload zparseopts zpr=
of zpty zregexparse zsocket zstyle ztcp",_:"-ne -eq -lt -gt -f -d -e -s -l =
-a"},c:[{cN:"meta",b:/^#![^\n]+sh\s*$/,r:10},{cN:"function",b:/\w[\w\d_]*\s=
*\(\s*\)\s*\{/,rB:!0,c:[e.inherit(e.TM,{b:/\w[\w\d_]*/})],r:0},e.HCM,s,a,t]=
}});hljs.registerLanguage("php",function(e){var c=3D{b:"\\$+[a-zA-Z_=7F-=C3=
=BF][a-zA-Z0-9_=7F-=C3=BF]*"},i=3D{cN:"meta",b:/<\?(php)?|\?>/},t=3D{cN:"st=
ring",c:[e.BE,i],v:[{b:'b"',e:'"'},{b:"b'",e:"'"},e.inherit(e.ASM,{i:null})=
,e.inherit(e.QSM,{i:null})]},a=3D{v:[e.BNM,e.CNM]};return{aliases:["php3","=
php4","php5","php6"],cI:!0,k:"and include_once list abstract global private=
 echo interface as static endswitch array null if endwhile or const for end=
foreach self var while isset public protected exit foreach throw elseif inc=
lude __FILE__ empty require_once do xor return parent clone use __CLASS__ _=
_LINE__ else break print eval new catch __METHOD__ case exception default d=
ie require __FUNCTION__ enddeclare final try switch continue endfor endif d=
eclare unset true false trait goto instanceof insteadof __DIR__ __NAMESPACE=
__ yield finally",c:[e.HCM,e.C("//","$",{c:[i]}),e.C("/\\*","\\*/",{c:[{cN:=
"doctag",b:"@[A-Za-z]+"}]}),e.C("__halt_compiler.+?;",!1,{eW:!0,k:"__halt_c=
ompiler",l:e.UIR}),{cN:"string",b:/<<<['"]?\w+['"]?$/,e:/^\w+;?$/,c:[e.BE,{=
cN:"subst",v:[{b:/\$\w+/},{b:/\{\$/,e:/\}/}]}]},i,{cN:"keyword",b:/\$this\b=
/},c,{b:/(::|->)+[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*/},{cN:"function",=
bK:"function",e:/[;{]/,eE:!0,i:"\\$|\\[|%",c:[e.UTM,{cN:"params",b:"\\(",e:=
"\\)",c:["self",c,e.CBCM,t,a]}]},{cN:"class",bK:"class interface",e:"{",eE:=
!0,i:/[:\(\$"]/,c:[{bK:"extends implements"},e.UTM]},{bK:"namespace",e:";",=
i:/[\.']/,c:[e.UTM]},{bK:"use",e:";",c:[e.UTM]},{b:"=3D>"},t,a]}});hljs.reg=
isterLanguage("python",function(e){var r=3D{keyword:"and elif is global as =
in if from raise for except finally print import pass return exec else brea=
k not with class assert yield try while continue del or def lambda async aw=
ait nonlocal|10 None True False",built_in:"Ellipsis NotImplemented"},b=3D{c=
N:"meta",b:/^(>>>|\.\.\.) /},c=3D{cN:"subst",b:/\{/,e:/\}/,k:r,i:/#/},a=3D{=
cN:"string",c:[e.BE],v:[{b:/(u|b)?r?'''/,e:/'''/,c:[b],r:10},{b:/(u|b)?r?""=
"/,e:/"""/,c:[b],r:10},{b:/(fr|rf|f)'''/,e:/'''/,c:[b,c]},{b:/(fr|rf|f)"""/=
,e:/"""/,c:[b,c]},{b:/(u|r|ur)'/,e:/'/,r:10},{b:/(u|r|ur)"/,e:/"/,r:10},{b:=
/(b|br)'/,e:/'/},{b:/(b|br)"/,e:/"/},{b:/(fr|rf|f)'/,e:/'/,c:[c]},{b:/(fr|r=
f|f)"/,e:/"/,c:[c]},e.ASM,e.QSM]},s=3D{cN:"number",r:0,v:[{b:e.BNR+"[lLjJ]?=
"},{b:"\\b(0o[0-7]+)[lLjJ]?"},{b:e.CNR+"[lLjJ]?"}]},i=3D{cN:"params",b:/\(/=
,e:/\)/,c:["self",b,s,a]};return c.c=3D[a,s,b],{aliases:["py","gyp"],k:r,i:=
/(<\/|->|\?)|=3D>/,c:[b,s,a,e.HCM,{v:[{cN:"function",bK:"def"},{cN:"class",=
bK:"class"}],e:/:/,i:/[${=3D;\n,]/,c:[e.UTM,i,{b:/->/,eW:!0,k:"None"}]},{cN=
:"meta",b:/^[\t ]*@/,e:/$/},{b:/\b(print|exec)\(/}]}});hljs.registerLanguag=
e("coffeescript",function(e){var c=3D{keyword:"in if for while finally new =
do return else break catch instanceof throw try this switch continue typeof=
 delete debugger super yield import export from as default await then unles=
s until loop of by when and or is isnt not",literal:"true false null undefi=
ned yes no on off",built_in:"npm require console print module global window=
 document"},n=3D"[A-Za-z$_][0-9A-Za-z$_]*",r=3D{cN:"subst",b:/#\{/,e:/}/,k:=
c},i=3D[e.BNM,e.inherit(e.CNM,{starts:{e:"(\\s*/)?",r:0}}),{cN:"string",v:[=
{b:/'''/,e:/'''/,c:[e.BE]},{b:/'/,e:/'/,c:[e.BE]},{b:/"""/,e:/"""/,c:[e.BE,=
r]},{b:/"/,e:/"/,c:[e.BE,r]}]},{cN:"regexp",v:[{b:"///",e:"///",c:[r,e.HCM]=
},{b:"//[gim]*",r:0},{b:/\/(?![ *])(\\\/|.)*?\/[gim]*(?=3D\W|$)/}]},{b:"@"+=
n},{sL:"javascript",eB:!0,eE:!0,v:[{b:"```",e:"```"},{b:"`",e:"`"}]}];r.c=
=3Di;var s=3De.inherit(e.TM,{b:n}),t=3D"(\\(.*\\))?\\s*\\B[-=3D]>",o=3D{cN:=
"params",b:"\\([^\\(]",rB:!0,c:[{b:/\(/,e:/\)/,k:c,c:["self"].concat(i)}]};=
return{aliases:["coffee","cson","iced"],k:c,i:/\/\*/,c:i.concat([e.C("###",=
"###"),e.HCM,{cN:"function",b:"^\\s*"+n+"\\s*=3D\\s*"+t,e:"[-=3D]>",rB:!0,c=
:[s,o]},{b:/[:\(,=3D]\s*/,r:0,c:[{cN:"function",b:t,e:"[-=3D]>",rB:!0,c:[o]=
}]},{cN:"class",bK:"class",e:"$",i:/[:=3D"\[\]]/,c:[{bK:"extends",eW:!0,i:/=
[:=3D"\[\]]/,c:[s]},s]},{b:n+":",e:":",rB:!0,rE:!0,r:0}])}});hljs.registerL=
anguage("cpp",function(t){var e=3D{cN:"keyword",b:"\\b[a-z\\d_]*_t\\b"},r=
=3D{cN:"string",v:[{b:'(u8?|U)?L?"',e:'"',i:"\\n",c:[t.BE]},{b:'(u8?|U)?R"'=
,e:'"',c:[t.BE]},{b:"'\\\\?.",e:"'",i:"."}]},s=3D{cN:"number",v:[{b:"\\b(0b=
[01']+)"},{b:"(-?)\\b([\\d']+(\\.[\\d']*)?|\\.[\\d']+)(u|U|l|L|ul|UL|f|F|b|=
B)"},{b:"(-?)(\\b0[xX][a-fA-F0-9']+|(\\b[\\d']+(\\.[\\d']*)?|\\.[\\d']+)([e=
E][-+]?[\\d']+)?)"}],r:0},i=3D{cN:"meta",b:/#\s*[a-z]+\b/,e:/$/,k:{"meta-ke=
yword":"if else elif endif define undef warning error line pragma ifdef ifn=
def include"},c:[{b:/\\\n/,r:0},t.inherit(r,{cN:"meta-string"}),{cN:"meta-s=
tring",b:/<[^\n>]*>/,e:/$/,i:"\\n"},t.CLCM,t.CBCM]},a=3Dt.IR+"\\s*\\(",c=3D=
{keyword:"int float while private char catch import module export virtual o=
perator sizeof dynamic_cast|10 typedef const_cast|10 const for static_cast|=
10 union namespace unsigned long volatile static protected bool template mu=
table if public friend do goto auto void enum else break extern using asm c=
ase typeid short reinterpret_cast|10 default double register explicit signe=
d typename try this switch continue inline delete alignof constexpr decltyp=
e noexcept static_assert thread_local restrict _Bool complex _Complex _Imag=
inary atomic_bool atomic_char atomic_schar atomic_uchar atomic_short atomic=
_ushort atomic_int atomic_uint atomic_long atomic_ulong atomic_llong atomic=
_ullong new throw return and or not",built_in:"std string cin cout cerr clo=
g stdin stdout stderr stringstream istringstream ostringstream auto_ptr deq=
ue list queue stack vector map set bitset multiset multimap unordered_set u=
nordered_map unordered_multiset unordered_multimap array shared_ptr abort a=
bs acos asin atan2 atan calloc ceil cosh cos exit exp fabs floor fmod fprin=
tf fputs free frexp fscanf isalnum isalpha iscntrl isdigit isgraph islower =
isprint ispunct isspace isupper isxdigit tolower toupper labs ldexp log10 l=
og malloc realloc memchr memcmp memcpy memset modf pow printf putchar puts =
scanf sinh sin snprintf sprintf sqrt sscanf strcat strchr strcmp strcpy str=
cspn strlen strncat strncmp strncpy strpbrk strrchr strspn strstr tanh tan =
vfprintf vprintf vsprintf endl initializer_list unique_ptr",literal:"true f=
alse nullptr NULL"},n=3D[e,t.CLCM,t.CBCM,s,r];return{aliases:["c","cc","h",=
"c++","h++","hpp"],k:c,i:"</",c:n.concat([i,{b:"\\b(deque|list|queue|stack|=
vector|map|set|bitset|multiset|multimap|unordered_map|unordered_set|unorder=
ed_multiset|unordered_multimap|array)\\s*<",e:">",k:c,c:["self",e]},{b:t.IR=
+"::",k:c},{v:[{b:/=3D/,e:/;/},{b:/\(/,e:/\)/},{bK:"new throw return else",=
e:/;/}],k:c,c:n.concat([{b:/\(/,e:/\)/,k:c,c:n.concat(["self"]),r:0}]),r:0}=
,{cN:"function",b:"("+t.IR+"[\\*&\\s]+)+"+a,rB:!0,e:/[{;=3D]/,eE:!0,k:c,i:/=
[^\w\s\*&]/,c:[{b:a,rB:!0,c:[t.TM],r:0},{cN:"params",b:/\(/,e:/\)/,k:c,r:0,=
c:[t.CLCM,t.CBCM,r,s,e]},t.CLCM,t.CBCM,i]},{cN:"class",bK:"class struct",e:=
/[{;:]/,c:[{b:/</,e:/>/,c:["self"]},t.TM]}]),exports:{preprocessor:i,string=
s:r,k:c}}});hljs.registerLanguage("cs",function(e){var i=3D{keyword:"abstra=
ct as base bool break byte case catch char checked const continue decimal d=
efault delegate do double enum event explicit extern finally fixed float fo=
r foreach goto if implicit in int interface internal is lock long nameof ob=
ject operator out override params private protected public readonly ref sby=
te sealed short sizeof stackalloc static string struct switch this try type=
of uint ulong unchecked unsafe ushort using virtual void volatile while add=
 alias ascending async await by descending dynamic equals from get global g=
roup into join let on orderby partial remove select set value var where yie=
ld",literal:"null false true"},t=3D{cN:"string",b:'@"',e:'"',c:[{b:'""'}]},=
r=3De.inherit(t,{i:/\n/}),a=3D{cN:"subst",b:"{",e:"}",k:i},c=3De.inherit(a,=
{i:/\n/}),n=3D{cN:"string",b:/\$"/,e:'"',i:/\n/,c:[{b:"{{"},{b:"}}"},e.BE,c=
]},s=3D{cN:"string",b:/\$@"/,e:'"',c:[{b:"{{"},{b:"}}"},{b:'""'},a]},o=3De.=
inherit(s,{i:/\n/,c:[{b:"{{"},{b:"}}"},{b:'""'},c]});a.c=3D[s,n,t,e.ASM,e.Q=
SM,e.CNM,e.CBCM],c.c=3D[o,n,r,e.ASM,e.QSM,e.CNM,e.inherit(e.CBCM,{i:/\n/})]=
;var l=3D{v:[s,n,t,e.ASM,e.QSM]},b=3De.IR+"(<"+e.IR+"(\\s*,\\s*"+e.IR+")*>)=
?(\\[\\])?";return{aliases:["csharp"],k:i,i:/::/,c:[e.C("///","$",{rB:!0,c:=
[{cN:"doctag",v:[{b:"///",r:0},{b:"<!--|-->"},{b:"</?",e:">"}]}]}),e.CLCM,e=
.CBCM,{cN:"meta",b:"#",e:"$",k:{"meta-keyword":"if else elif endif define u=
ndef warning error line region endregion pragma checksum"}},l,e.CNM,{bK:"cl=
ass interface",e:/[{;=3D]/,i:/[^\s:]/,c:[e.TM,e.CLCM,e.CBCM]},{bK:"namespac=
e",e:/[{;=3D]/,i:/[^\s:]/,c:[e.inherit(e.TM,{b:"[a-zA-Z](\\.?\\w)*"}),e.CLC=
M,e.CBCM]},{cN:"meta",b:"^\\s*\\[",eB:!0,e:"\\]",eE:!0,c:[{cN:"meta-string"=
,b:/"/,e:/"/}]},{bK:"new return throw await else",r:0},{cN:"function",b:"("=
+b+"\\s+)+"+e.IR+"\\s*\\(",rB:!0,e:/[{;=3D]/,eE:!0,k:i,c:[{b:e.IR+"\\s*\\("=
,rB:!0,c:[e.TM],r:0},{cN:"params",b:/\(/,e:/\)/,eB:!0,eE:!0,k:i,r:0,c:[l,e.=
CNM,e.CBCM]},e.CLCM,e.CBCM]}]}});hljs.registerLanguage("shell",function(s){=
return{aliases:["console"],c:[{cN:"meta",b:"^\\s{0,3}[\\w\\d\\[\\]()@-]*[>%=
$#]",starts:{e:"$",sL:"bash"}}]}});hljs.registerLanguage("ruby",function(e)=
{var b=3D"[a-zA-Z_]\\w*[!?=3D]?|[-+~]\\@|<<|>>|=3D~|=3D=3D=3D?|<=3D>|[<>]=
=3D?|\\*\\*|[-/+%^&*~`|]|\\[\\]=3D?",r=3D{keyword:"and then defined module =
in return redo if BEGIN retry end for self when next until do begin unless =
END rescue else break undef not super class case require yield alias while =
ensure elsif or include attr_reader attr_writer attr_accessor",literal:"tru=
e false nil"},c=3D{cN:"doctag",b:"@[A-Za-z]+"},a=3D{b:"#<",e:">"},s=3D[e.C(=
"#","$",{c:[c]}),e.C("^\\=3Dbegin","^\\=3Dend",{c:[c],r:10}),e.C("^__END__"=
,"\\n$")],n=3D{cN:"subst",b:"#\\{",e:"}",k:r},t=3D{cN:"string",c:[e.BE,n],v=
:[{b:/'/,e:/'/},{b:/"/,e:/"/},{b:/`/,e:/`/},{b:"%[qQwWx]?\\(",e:"\\)"},{b:"=
%[qQwWx]?\\[",e:"\\]"},{b:"%[qQwWx]?{",e:"}"},{b:"%[qQwWx]?<",e:">"},{b:"%[=
qQwWx]?/",e:"/"},{b:"%[qQwWx]?%",e:"%"},{b:"%[qQwWx]?-",e:"-"},{b:"%[qQwWx]=
?\\|",e:"\\|"},{b:/\B\?(\\\d{1,3}|\\x[A-Fa-f0-9]{1,2}|\\u[A-Fa-f0-9]{4}|\\?=
\S)\b/},{b:/<<(-?)\w+$/,e:/^\s*\w+$/}]},i=3D{cN:"params",b:"\\(",e:"\\)",en=
dsParent:!0,k:r},d=3D[t,a,{cN:"class",bK:"class module",e:"$|;",i:/=3D/,c:[=
e.inherit(e.TM,{b:"[A-Za-z_]\\w*(::\\w+)*(\\?|\\!)?"}),{b:"<\\s*",c:[{b:"("=
+e.IR+"::)?"+e.IR}]}].concat(s)},{cN:"function",bK:"def",e:"$|;",c:[e.inher=
it(e.TM,{b:b}),i].concat(s)},{b:e.IR+"::"},{cN:"symbol",b:e.UIR+"(\\!|\\?)?=
:",r:0},{cN:"symbol",b:":(?!\\s)",c:[t,{b:b}],r:0},{cN:"number",b:"(\\b0[0-=
7_]+)|(\\b0x[0-9a-fA-F_]+)|(\\b[1-9][0-9_]*(\\.[0-9_]+)?)|[0_]\\b",r:0},{b:=
"(\\$\\W)|((\\$|\\@\\@?)(\\w+))"},{cN:"params",b:/\|/,e:/\|/,k:r},{b:"("+e.=
RSR+"|unless)\\s*",k:"unless",c:[a,{cN:"regexp",c:[e.BE,n],i:/\n/,v:[{b:"/"=
,e:"/[a-z]*"},{b:"%r{",e:"}[a-z]*"},{b:"%r\\(",e:"\\)[a-z]*"},{b:"%r!",e:"!=
[a-z]*"},{b:"%r\\[",e:"\\][a-z]*"}]}].concat(s),r:0}].concat(s);n.c=3Dd,i.c=
=3Dd;var l=3D"[>?]>",o=3D"[\\w#]+\\(\\w+\\):\\d+:\\d+>",u=3D"(\\w+-)?\\d+\\=
.\\d+\\.\\d(p\\d+)?[^>]+>",w=3D[{b:/^\s*=3D>/,starts:{e:"$",c:d}},{cN:"meta=
",b:"^("+l+"|"+o+"|"+u+")",starts:{e:"$",c:d}}];return{aliases:["rb","gemsp=
ec","podspec","thor","irb"],k:r,i:/\/\*/,c:s.concat(w).concat(d)}});hljs.re=
gisterLanguage("nginx",function(e){var r=3D{cN:"variable",v:[{b:/\$\d+/},{b=
:/\$\{/,e:/}/},{b:"[\\$\\@]"+e.UIR}]},b=3D{eW:!0,l:"[a-z/_]+",k:{literal:"o=
n off yes no true false none blocked debug info notice warn error crit sele=
ct break last permanent redirect kqueue rtsig epoll poll /dev/poll"},r:0,i:=
"=3D>",c:[e.HCM,{cN:"string",c:[e.BE,r],v:[{b:/"/,e:/"/},{b:/'/,e:/'/}]},{b=
:"([a-z]+):/",e:"\\s",eW:!0,eE:!0,c:[r]},{cN:"regexp",c:[e.BE,r],v:[{b:"\\s=
\\^",e:"\\s|{|;",rE:!0},{b:"~\\*?\\s+",e:"\\s|{|;",rE:!0},{b:"\\*(\\.[a-z\\=
-]+)+"},{b:"([a-z\\-]+\\.)+\\*"}]},{cN:"number",b:"\\b\\d{1,3}\\.\\d{1,3}\\=
.\\d{1,3}\\.\\d{1,3}(:\\d{1,5})?\\b"},{cN:"number",b:"\\b\\d+[kKmMgGdshdwy]=
*\\b",r:0},r]};return{aliases:["nginxconf"],c:[e.HCM,{b:e.UIR+"\\s+{",rB:!0=
,e:"{",c:[{cN:"section",b:e.UIR}],r:0},{b:e.UIR+"\\s",e:";|{",rB:!0,c:[{cN:=
"attribute",b:e.UIR,starts:b}],r:0}],i:"[^\\s\\}]"}});hljs.registerLanguage=
("css",function(e){var c=3D"[a-zA-Z-][a-zA-Z0-9_-]*",t=3D{b:/[A-Z\_\.\-]+\s=
*:/,rB:!0,e:";",eW:!0,c:[{cN:"attribute",b:/\S/,e:":",eE:!0,starts:{eW:!0,e=
E:!0,c:[{b:/[\w-]+\(/,rB:!0,c:[{cN:"built_in",b:/[\w-]+/},{b:/\(/,e:/\)/,c:=
[e.ASM,e.QSM]}]},e.CSSNM,e.QSM,e.ASM,e.CBCM,{cN:"number",b:"#[0-9A-Fa-f]+"}=
,{cN:"meta",b:"!important"}]}}]};return{cI:!0,i:/[=3D\/|'\$]/,c:[e.CBCM,{cN=
:"selector-id",b:/#[A-Za-z0-9_-]+/},{cN:"selector-class",b:/\.[A-Za-z0-9_-]=
+/},{cN:"selector-attr",b:/\[/,e:/\]/,i:"$"},{cN:"selector-pseudo",b:/:(:)?=
[a-zA-Z0-9\_\-\+\(\)"'.]+/},{b:"@(font-face|page)",l:"[a-z-]+",k:"font-face=
 page"},{b:"@",e:"[{;]",i:/:/,c:[{cN:"keyword",b:/\w+/},{b:/\s/,eW:!0,eE:!0=
,r:0,c:[e.ASM,e.QSM,e.CSSNM]}]},{cN:"selector-tag",b:c,r:0},{b:"{",e:"}",i:=
/\S/,c:[e.CBCM,t]}]}});hljs.registerLanguage("makefile",function(e){var i=
=3D{cN:"variable",v:[{b:"\\$\\("+e.UIR+"\\)",c:[e.BE]},{b:/\$[@%<?\^\+\*]/}=
]},r=3D{cN:"string",b:/"/,e:/"/,c:[e.BE,i]},a=3D{cN:"variable",b:/\$\([\w-]=
+\s/,e:/\)/,k:{built_in:"subst patsubst strip findstring filter filter-out =
sort word wordlist firstword lastword dir notdir suffix basename addsuffix =
addprefix join wildcard realpath abspath error warning shell origin flavor =
foreach if or and call eval file value"},c:[i]},n=3D{b:"^"+e.UIR+"\\s*[:+?]=
?=3D",i:"\\n",rB:!0,c:[{b:"^"+e.UIR,e:"[:+?]?=3D",eE:!0}]},t=3D{cN:"meta",b=
:/^\.PHONY:/,e:/$/,k:{"meta-keyword":".PHONY"},l:/[\.\w]+/},l=3D{cN:"sectio=
n",b:/^[^\s]+:/,e:/$/,c:[i]};return{aliases:["mk","mak"],k:"define endef un=
define ifdef ifndef ifeq ifneq else endif include -include sinclude overrid=
e export unexport private vpath",l:/[\w-]+/,c:[e.HCM,i,r,a,n,t,l]}});hljs.r=
egisterLanguage("java",function(e){var a=3D"[=C3=80-=CA=B8a-zA-Z_$][=C3=80-=
=CA=B8a-zA-Z_$0-9]*",t=3Da+"(<"+a+"(\\s*,\\s*"+a+")*>)?",r=3D"false synchro=
nized int abstract float private char boolean static null if const for true=
 while long strictfp finally protected import native final void enum else b=
reak transient catch instanceof byte super volatile case assert short packa=
ge default double public try this switch continue throws protected public p=
rivate module requires exports do",s=3D"\\b(0[bB]([01]+[01_]+[01]+|[01]+)|0=
[xX]([a-fA-F0-9]+[a-fA-F0-9_]+[a-fA-F0-9]+|[a-fA-F0-9]+)|(([\\d]+[\\d_]+[\\=
d]+|[\\d]+)(\\.([\\d]+[\\d_]+[\\d]+|[\\d]+))?|\\.([\\d]+[\\d_]+[\\d]+|[\\d]=
+))([eE][-+]?\\d+)?)[lLfF]?",c=3D{cN:"number",b:s,r:0};return{aliases:["jsp=
"],k:r,i:/<\/|#/,c:[e.C("/\\*\\*","\\*/",{r:0,c:[{b:/\w+@/,r:0},{cN:"doctag=
",b:"@[A-Za-z]+"}]}),e.CLCM,e.CBCM,e.ASM,e.QSM,{cN:"class",bK:"class interf=
ace",e:/[{;=3D]/,eE:!0,k:"class interface",i:/[:"\[\]]/,c:[{bK:"extends imp=
lements"},e.UTM]},{bK:"new throw return else",r:0},{cN:"function",b:"("+t+"=
\\s+)+"+e.UIR+"\\s*\\(",rB:!0,e:/[{;=3D]/,eE:!0,k:r,c:[{b:e.UIR+"\\s*\\(",r=
B:!0,r:0,c:[e.UTM]},{cN:"params",b:/\(/,e:/\)/,k:r,r:0,c:[e.ASM,e.QSM,e.CNM=
,e.CBCM]},e.CLCM,e.CBCM]},c,{cN:"meta",b:"@[A-Za-z]+"}]}});hljs.registerLan=
guage("http",function(e){var t=3D"HTTP/[0-9\\.]+";return{aliases:["https"],=
i:"\\S",c:[{b:"^"+t,e:"$",c:[{cN:"number",b:"\\b\\d{3}\\b"}]},{b:"^[A-Z]+ (=
.*?) "+t+"$",rB:!0,e:"$",c:[{cN:"string",b:" ",e:" ",eB:!0,eE:!0},{b:t},{cN=
:"keyword",b:"[A-Z]+"}]},{cN:"attribute",b:"^\\w",e:": ",eE:!0,i:"\\n|\\s|=
=3D",starts:{e:"$",r:0}},{b:"\\n\\n",starts:{sL:[],eW:!0}}]}});hljs.registe=
rLanguage("objectivec",function(e){var t=3D{cN:"built_in",b:"\\b(AV|CA|CF|C=
G|CI|CL|CM|CN|CT|MK|MP|MTK|MTL|NS|SCN|SK|UI|WK|XC)\\w+"},_=3D{keyword:"int =
float while char export sizeof typedef const struct for union unsigned long=
 volatile static bool mutable if do return goto void enum else break extern=
 asm case short default double register explicit signed typename this switc=
h continue wchar_t inline readonly assign readwrite self @synchronized id t=
ypeof nonatomic super unichar IBOutlet IBAction strong weak copy in out ino=
ut bycopy byref oneway __strong __weak __block __autoreleasing @private @pr=
otected @public @try @property @end @throw @catch @finally @autoreleasepool=
 @synthesize @dynamic @selector @optional @required @encode @package @impor=
t @defs @compatibility_alias __bridge __bridge_transfer __bridge_retained _=
_bridge_retain __covariant __contravariant __kindof _Nonnull _Nullable _Nul=
l_unspecified __FUNCTION__ __PRETTY_FUNCTION__ __attribute__ getter setter =
retain unsafe_unretained nonnull nullable null_unspecified null_resettable =
class instancetype NS_DESIGNATED_INITIALIZER NS_UNAVAILABLE NS_REQUIRES_SUP=
ER NS_RETURNS_INNER_POINTER NS_INLINE NS_AVAILABLE NS_DEPRECATED NS_ENUM NS=
_OPTIONS NS_SWIFT_UNAVAILABLE NS_ASSUME_NONNULL_BEGIN NS_ASSUME_NONNULL_END=
 NS_REFINED_FOR_SWIFT NS_SWIFT_NAME NS_SWIFT_NOTHROW NS_DURING NS_HANDLER N=
S_ENDHANDLER NS_VALUERETURN NS_VOIDRETURN",literal:"false true FALSE TRUE n=
il YES NO NULL",built_in:"BOOL dispatch_once_t dispatch_queue_t dispatch_sy=
nc dispatch_async dispatch_once"},i=3D/[a-zA-Z@][a-zA-Z0-9_]*/,n=3D"@interf=
ace @class @protocol @implementation";return{aliases:["mm","objc","obj-c"],=
k:_,l:i,i:"</",c:[t,e.CLCM,e.CBCM,e.CNM,e.QSM,{cN:"string",v:[{b:'@"',e:'"'=
,i:"\\n",c:[e.BE]},{b:"'",e:"[^\\\\]'",i:"[^\\\\][^']"}]},{cN:"meta",b:"#",=
e:"$",c:[{cN:"meta-string",v:[{b:'"',e:'"'},{b:"<",e:">"}]}]},{cN:"class",b=
:"("+n.split(" ").join("|")+")\\b",e:"({|$)",eE:!0,k:n,l:i,c:[e.UTM]},{b:"\=
\."+e.UIR,r:0}]}});hljs.registerLanguage("javascript",function(e){var r=3D"=
[A-Za-z$_][0-9A-Za-z$_]*",t=3D{keyword:"in of if for while finally var new =
function do return void else break catch instanceof with throw case default=
 try this switch continue typeof delete let yield const export super debugg=
er as async await static import from as",literal:"true false null undefined=
 NaN Infinity",built_in:"eval isFinite isNaN parseFloat parseInt decodeURI =
decodeURIComponent encodeURI encodeURIComponent escape unescape Object Func=
tion Boolean Error EvalError InternalError RangeError ReferenceError StopIt=
eration SyntaxError TypeError URIError Number Math Date String RegExp Array=
 Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint=
32Array Uint8Array Uint8ClampedArray ArrayBuffer DataView JSON Intl argumen=
ts require module console window document Symbol Set Map WeakSet WeakMap Pr=
oxy Reflect Promise"},a=3D{cN:"number",v:[{b:"\\b(0[bB][01]+)"},{b:"\\b(0[o=
O][0-7]+)"},{b:e.CNR}],r:0},n=3D{cN:"subst",b:"\\$\\{",e:"\\}",k:t,c:[]},c=
=3D{cN:"string",b:"`",e:"`",c:[e.BE,n]};n.c=3D[e.ASM,e.QSM,c,a,e.RM];var s=
=3Dn.c.concat([e.CBCM,e.CLCM]);return{aliases:["js","jsx"],k:t,c:[{cN:"meta=
",r:10,b:/^\s*['"]use (strict|asm)['"]/},{cN:"meta",b:/^#!/,e:/$/},e.ASM,e.=
QSM,c,e.CLCM,e.CBCM,a,{b:/[{,]\s*/,r:0,c:[{b:r+"\\s*:",rB:!0,r:0,c:[{cN:"at=
tr",b:r,r:0}]}]},{b:"("+e.RSR+"|\\b(case|return|throw)\\b)\\s*",k:"return t=
hrow case",c:[e.CLCM,e.CBCM,e.RM,{cN:"function",b:"(\\(.*?\\)|"+r+")\\s*=3D=
>",rB:!0,e:"\\s*=3D>",c:[{cN:"params",v:[{b:r},{b:/\(\s*\)/},{b:/\(/,e:/\)/=
,eB:!0,eE:!0,k:t,c:s}]}]},{b:/</,e:/(\/\w+|\w+\/)>/,sL:"xml",c:[{b:/<\w+\s*=
\/>/,skip:!0},{b:/<\w+/,e:/(\/\w+|\w+\/)>/,skip:!0,c:[{b:/<\w+\s*\/>/,skip:=
!0},"self"]}]}],r:0},{cN:"function",bK:"function",e:/\{/,eE:!0,c:[e.inherit=
(e.TM,{b:r}),{cN:"params",b:/\(/,e:/\)/,eB:!0,eE:!0,c:s}],i:/\[|%/},{b:/\$[=
(.]/},e.METHOD_GUARD,{cN:"class",bK:"class",e:/[{;=3D]/,eE:!0,i:/[:"\[\]]/,=
c:[{bK:"extends"},e.UTM]},{bK:"constructor",e:/\{/,eE:!0}],i:/#(?!!)/}});hl=
js.registerLanguage("apache",function(e){var r=3D{cN:"number",b:"[\\$%]\\d+=
"};return{aliases:["apacheconf"],cI:!0,c:[e.HCM,{cN:"section",b:"</?",e:">"=
},{cN:"attribute",b:/\w+/,r:0,k:{nomarkup:"order deny allow setenv rewriter=
ule rewriteengine rewritecond documentroot sethandler errordocument loadmod=
ule options header listen serverroot servername"},starts:{e:/$/,r:0,k:{lite=
ral:"on off all"},c:[{cN:"meta",b:"\\s\\[",e:"\\]$"},{cN:"variable",b:"[\\$=
%]\\{",e:"\\}",c:["self",r]},r,e.QSM]}}],i:/\S/}});hljs.registerLanguage("x=
ml",function(s){var e=3D"[A-Za-z0-9\\._:-]+",t=3D{eW:!0,i:/</,r:0,c:[{cN:"a=
ttr",b:e,r:0},{b:/=3D\s*/,r:0,c:[{cN:"string",endsParent:!0,v:[{b:/"/,e:/"/=
},{b:/'/,e:/'/},{b:/[^\s"'=3D<>`]+/}]}]}]};return{aliases:["html","xhtml","=
rss","atom","xjb","xsd","xsl","plist"],cI:!0,c:[{cN:"meta",b:"<!DOCTYPE",e:=
">",r:10,c:[{b:"\\[",e:"\\]"}]},s.C("<!--","-->",{r:10}),{b:"<\\!\\[CDATA\\=
[",e:"\\]\\]>",r:10},{b:/<\?(php)?/,e:/\?>/,sL:"php",c:[{b:"/\\*",e:"\\*/",=
skip:!0}]},{cN:"tag",b:"<style(?=3D\\s|>|$)",e:">",k:{name:"style"},c:[t],s=
tarts:{e:"</style>",rE:!0,sL:["css","xml"]}},{cN:"tag",b:"<script(?=3D\\s|>=
|$)",e:">",k:{name:"script"},c:[t],starts:{e:"</script>",rE:!0,sL:["actions=
cript","javascript","handlebars","xml"]}},{cN:"meta",v:[{b:/<\?xml/,e:/\?>/=
,r:10},{b:/<\?\w+/,e:/\?>/}]},{cN:"tag",b:"</?",e:"/?>",c:[{cN:"name",b:/[^=
\/><\s]+/,r:0},t]}]}});hljs.registerLanguage("markdown",function(e){return{=
aliases:["md","mkdown","mkd"],c:[{cN:"section",v:[{b:"^#{1,6}",e:"$"},{b:"^=
.+?\\n[=3D-]{2,}$"}]},{b:"<",e:">",sL:"xml",r:0},{cN:"bullet",b:"^([*+-]|(\=
\d+\\.))\\s+"},{cN:"strong",b:"[*_]{2}.+?[*_]{2}"},{cN:"emphasis",v:[{b:"\\=
*.+?\\*"},{b:"_.+?_",r:0}]},{cN:"quote",b:"^>\\s+",e:"$"},{cN:"code",v:[{b:=
"^```w*s*$",e:"^```s*$"},{b:"`.+?`"},{b:"^( {4}|	)",e:"$",r:0}]},{b:"^[-\\*=
]{3,}",e:"$"},{b:"\\[.+?\\][\\(\\[].*?[\\)\\]]",rB:!0,c:[{cN:"string",b:"\\=
[",e:"\\]",eB:!0,rE:!0,r:0},{cN:"link",b:"\\]\\(",e:"\\)",eB:!0,eE:!0},{cN:=
"symbol",b:"\\]\\[",e:"\\]",eB:!0,eE:!0}],r:10},{b:/^\[[^\n]+\]:/,rB:!0,c:[=
{cN:"symbol",b:/\[/,e:/\]/,eB:!0,eE:!0},{cN:"link",b:/:\s*/,e:/$/,eB:!0}]}]=
}});hljs.registerLanguage("json",function(e){var i=3D{literal:"true false n=
ull"},n=3D[e.QSM,e.CNM],r=3D{e:",",eW:!0,eE:!0,c:n,k:i},t=3D{b:"{",e:"}",c:=
[{cN:"attr",b:/"/,e:/"/,c:[e.BE],i:"\\n"},e.inherit(r,{b:/:/})],i:"\\S"},c=
=3D{b:"\\[",e:"\\]",c:[e.inherit(r)],i:"\\S"};return n.splice(n.length,0,t,=
c),{c:n,k:i,i:"\\S"}});
\ No newline at end of file
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/t=
oastergui/static/js/libtoaster.js
index e7d6a95..6f9b5d0 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -546,11 +546,9 @@ $(document).ready(function() {
     }
=20
     /*
-     * PrettyPrint plugin.
-     *
+     * highlight plugin.
      */
-    // Init
-    prettyPrint();
+    hljs.initHighlightingOnLoad();
=20
     // Prevent invalid links from jumping page scroll
     $('a[href=3D#]').click(function() {
diff --git a/lib/toaster/toastergui/static/js/prettify.js b/lib/toaster/toa=
stergui/static/js/prettify.js
deleted file mode 100755
index eef5ad7..0000000
--- a/lib/toaster/toastergui/static/js/prettify.js
+++ /dev/null
@@ -1,28 +0,0 @@
-var q=3Dnull;window.PR_SHOULD_USE_CONTINUATION=3D!0;
-(function(){function L(a){function m(a){var f=3Da.charCodeAt(0);if(f!=3D=
=3D92)return f;var b=3Da.charAt(1);return(f=3Dr[b])?f:"0"<=3Db&&b<=3D"7"?pa=
rseInt(a.substring(1),8):b=3D=3D=3D"u"||b=3D=3D=3D"x"?parseInt(a.substring(=
2),16):a.charCodeAt(1)}function e(a){if(a<32)return(a<16?"\\x0":"\\x")+a.to=
String(16);a=3DString.fromCharCode(a);if(a=3D=3D=3D"\\"||a=3D=3D=3D"-"||a=
=3D=3D=3D"["||a=3D=3D=3D"]")a=3D"\\"+a;return a}function h(a){for(var f=3Da=
.substring(1,a.length-1).match(/\\u[\dA-Fa-f]{4}|\\x[\dA-Fa-f]{2}|\\[0-3][0=
-7]{0,2}|\\[0-7]{1,2}|\\[\S\s]|[^\\]/g),a=3D
-[],b=3D[],o=3Df[0]=3D=3D=3D"^",c=3Do?1:0,i=3Df.length;c<i;++c){var j=3Df[c=
];if(/\\[bdsw]/i.test(j))a.push(j);else{var j=3Dm(j),d;c+2<i&&"-"=3D=3D=3Df=
[c+1]?(d=3Dm(f[c+2]),c+=3D2):d=3Dj;b.push([j,d]);d<65||j>122||(d<65||j>90||=
b.push([Math.max(65,j)|32,Math.min(d,90)|32]),d<97||j>122||b.push([Math.max=
(97,j)&-33,Math.min(d,122)&-33]))}}b.sort(function(a,f){return a[0]-f[0]||f=
[1]-a[1]});f=3D[];j=3D[NaN,NaN];for(c=3D0;c<b.length;++c)i=3Db[c],i[0]<=3Dj=
[1]+1?j[1]=3DMath.max(j[1],i[1]):f.push(j=3Di);b=3D["["];o&&b.push("^");b.p=
ush.apply(b,a);for(c=3D0;c<
-f.length;++c)i=3Df[c],b.push(e(i[0])),i[1]>i[0]&&(i[1]+1>i[0]&&b.push("-")=
,b.push(e(i[1])));b.push("]");return b.join("")}function y(a){for(var f=3Da=
.source.match(/\[(?:[^\\\]]|\\[\S\s])*]|\\u[\dA-Fa-f]{4}|\\x[\dA-Fa-f]{2}|\=
\\d+|\\[^\dux]|\(\?[!:=3D]|[()^]|[^()[\\^]+/g),b=3Df.length,d=3D[],c=3D0,i=
=3D0;c<b;++c){var j=3Df[c];j=3D=3D=3D"("?++i:"\\"=3D=3D=3Dj.charAt(0)&&(j=
=3D+j.substring(1))&&j<=3Di&&(d[j]=3D-1)}for(c=3D1;c<d.length;++c)-1=3D=3D=
=3Dd[c]&&(d[c]=3D++t);for(i=3Dc=3D0;c<b;++c)j=3Df[c],j=3D=3D=3D"("?(++i,d[i=
]=3D=3D=3Dvoid 0&&(f[c]=3D"(?:")):"\\"=3D=3D=3Dj.charAt(0)&&
-(j=3D+j.substring(1))&&j<=3Di&&(f[c]=3D"\\"+d[i]);for(i=3Dc=3D0;c<b;++c)"^=
"=3D=3D=3Df[c]&&"^"!=3D=3Df[c+1]&&(f[c]=3D"");if(a.ignoreCase&&s)for(c=3D0;=
c<b;++c)j=3Df[c],a=3Dj.charAt(0),j.length>=3D2&&a=3D=3D=3D"["?f[c]=3Dh(j):a=
!=3D=3D"\\"&&(f[c]=3Dj.replace(/[A-Za-z]/g,function(a){a=3Da.charCodeAt(0);=
return"["+String.fromCharCode(a&-33,a|32)+"]"}));return f.join("")}for(var =
t=3D0,s=3D!1,l=3D!1,p=3D0,d=3Da.length;p<d;++p){var g=3Da[p];if(g.ignoreCas=
e)l=3D!0;else if(/[a-z]/i.test(g.source.replace(/\\u[\da-f]{4}|\\x[\da-f]{2=
}|\\[^UXux]/gi,""))){s=3D!0;l=3D!1;break}}for(var r=3D
-{b:8,t:9,n:10,v:11,f:12,r:13},n=3D[],p=3D0,d=3Da.length;p<d;++p){g=3Da[p];=
if(g.global||g.multiline)throw Error(""+g);n.push("(?:"+y(g)+")")}return Re=
gExp(n.join("|"),l?"gi":"g")}function M(a){function m(a){switch(a.nodeType)=
{case 1:if(e.test(a.className))break;for(var g=3Da.firstChild;g;g=3Dg.nextS=
ibling)m(g);g=3Da.nodeName;if("BR"=3D=3D=3Dg||"LI"=3D=3D=3Dg)h[s]=3D"\n",t[=
s<<1]=3Dy++,t[s++<<1|1]=3Da;break;case 3:case 4:g=3Da.nodeValue,g.length&&(=
g=3Dp?g.replace(/\r\n?/g,"\n"):g.replace(/[\t\n\r ]+/g," "),h[s]=3Dg,t[s<<1=
]=3Dy,y+=3Dg.length,
-t[s++<<1|1]=3Da)}}var e=3D/(?:^|\s)nocode(?:\s|$)/,h=3D[],y=3D0,t=3D[],s=
=3D0,l;a.currentStyle?l=3Da.currentStyle.whiteSpace:window.getComputedStyle=
&&(l=3Ddocument.defaultView.getComputedStyle(a,q).getPropertyValue("white-s=
pace"));var p=3Dl&&"pre"=3D=3D=3Dl.substring(0,3);m(a);return{a:h.join("").=
replace(/\n$/,""),c:t}}function B(a,m,e,h){m&&(a=3D{a:m,d:a},e(a),h.push.ap=
ply(h,a.e))}function x(a,m){function e(a){for(var l=3Da.d,p=3D[l,"pln"],d=
=3D0,g=3Da.a.match(y)||[],r=3D{},n=3D0,z=3Dg.length;n<z;++n){var f=3Dg[n],b=
=3Dr[f],o=3Dvoid 0,c;if(typeof b=3D=3D=3D
-"string")c=3D!1;else{var i=3Dh[f.charAt(0)];if(i)o=3Df.match(i[1]),b=3Di[0=
];else{for(c=3D0;c<t;++c)if(i=3Dm[c],o=3Df.match(i[1])){b=3Di[0];break}o||(=
b=3D"pln")}if((c=3Db.length>=3D5&&"lang-"=3D=3D=3Db.substring(0,5))&&!(o&&t=
ypeof o[1]=3D=3D=3D"string"))c=3D!1,b=3D"src";c||(r[f]=3Db)}i=3Dd;d+=3Df.le=
ngth;if(c){c=3Do[1];var j=3Df.indexOf(c),k=3Dj+c.length;o[2]&&(k=3Df.length=
-o[2].length,j=3Dk-c.length);b=3Db.substring(5);B(l+i,f.substring(0,j),e,p)=
;B(l+i+j,c,C(b,c),p);B(l+i+k,f.substring(k),e,p)}else p.push(l+i,b)}a.e=3Dp=
}var h=3D{},y;(function(){for(var e=3Da.concat(m),
-l=3D[],p=3D{},d=3D0,g=3De.length;d<g;++d){var r=3De[d],n=3Dr[3];if(n)for(v=
ar k=3Dn.length;--k>=3D0;)h[n.charAt(k)]=3Dr;r=3Dr[1];n=3D""+r;p.hasOwnProp=
erty(n)||(l.push(r),p[n]=3Dq)}l.push(/[\S\s]/);y=3DL(l)})();var t=3Dm.lengt=
h;return e}function u(a){var m=3D[],e=3D[];a.tripleQuotedStrings?m.push(["s=
tr",/^(?:'''(?:[^'\\]|\\[\S\s]|''?(?=3D[^']))*(?:'''|$)|"""(?:[^"\\]|\\[\S\=
s]|""?(?=3D[^"]))*(?:"""|$)|'(?:[^'\\]|\\[\S\s])*(?:'|$)|"(?:[^"\\]|\\[\S\s=
])*(?:"|$))/,q,"'\""]):a.multiLineStrings?m.push(["str",/^(?:'(?:[^'\\]|\\[=
\S\s])*(?:'|$)|"(?:[^"\\]|\\[\S\s])*(?:"|$)|`(?:[^\\`]|\\[\S\s])*(?:`|$))/,
-q,"'\"`"]):m.push(["str",/^(?:'(?:[^\n\r'\\]|\\.)*(?:'|$)|"(?:[^\n\r"\\]|\=
\.)*(?:"|$))/,q,"\"'"]);a.verbatimStrings&&e.push(["str",/^@"(?:[^"]|"")*(?=
:"|$)/,q]);var h=3Da.hashComments;h&&(a.cStyleComments?(h>1?m.push(["com",/=
^#(?:##(?:[^#]|#(?!##))*(?:###|$)|.*)/,q,"#"]):m.push(["com",/^#(?:(?:defin=
e|elif|else|endif|error|ifdef|include|ifndef|line|pragma|undef|warning)\b|[=
^\n\r]*)/,q,"#"]),e.push(["str",/^<(?:(?:(?:\.\.\/)*|\/?)(?:[\w-]+(?:\/[\w-=
]+)+)?[\w-]+\.h|[a-z]\w*)>/,q])):m.push(["com",/^#[^\n\r]*/,
-q,"#"]));a.cStyleComments&&(e.push(["com",/^\/\/[^\n\r]*/,q]),e.push(["com=
",/^\/\*[\S\s]*?(?:\*\/|$)/,q]));a.regexLiterals&&e.push(["lang-regex",/^(?=
:^^\.?|[!+-]|!=3D|!=3D=3D|#|%|%=3D|&|&&|&&=3D|&=3D|\(|\*|\*=3D|\+=3D|,|-=3D=
|->|\/|\/=3D|:|::|;|<|<<|<<=3D|<=3D|=3D|=3D=3D|=3D=3D=3D|>|>=3D|>>|>>=3D|>>=
>|>>>=3D|[?@[^]|\^=3D|\^\^|\^\^=3D|{|\||\|=3D|\|\||\|\|=3D|~|break|case|con=
tinue|delete|do|else|finally|instanceof|return|throw|try|typeof)\s*(\/(?=3D=
[^*/])(?:[^/[\\]|\\[\S\s]|\[(?:[^\\\]]|\\[\S\s])*(?:]|$))+\/)/]);(h=3Da.typ=
es)&&e.push(["typ",h]);a=3D(""+a.keywords).replace(/^ | $/g,
-"");a.length&&e.push(["kwd",RegExp("^(?:"+a.replace(/[\s,]+/g,"|")+")\\b")=
,q]);m.push(["pln",/^\s+/,q," \r\n\t\xa0"]);e.push(["lit",/^@[$_a-z][\w$@]*=
/i,q],["typ",/^(?:[@_]?[A-Z]+[a-z][\w$@]*|\w+_t\b)/,q],["pln",/^[$_a-z][\w$=
@]*/i,q],["lit",/^(?:0x[\da-f]+|(?:\d(?:_\d+)*\d*(?:\.\d*)?|\.\d\+)(?:e[+-]=
?\d+)?)[a-z]*/i,q,"0123456789"],["pln",/^\\[\S\s]?/,q],["pun",/^.[^\s\w"-$'=
./@\\`]*/,q]);return x(m,e)}function D(a,m){function e(a){switch(a.nodeType=
){case 1:if(k.test(a.className))break;if("BR"=3D=3D=3Da.nodeName)h(a),
-a.parentNode&&a.parentNode.removeChild(a);else for(a=3Da.firstChild;a;a=3D=
a.nextSibling)e(a);break;case 3:case 4:if(p){var b=3Da.nodeValue,d=3Db.matc=
h(t);if(d){var c=3Db.substring(0,d.index);a.nodeValue=3Dc;(b=3Db.substring(=
d.index+d[0].length))&&a.parentNode.insertBefore(s.createTextNode(b),a.next=
Sibling);h(a);c||a.parentNode.removeChild(a)}}}}function h(a){function b(a,=
d){var e=3Dd?a.cloneNode(!1):a,f=3Da.parentNode;if(f){var f=3Db(f,1),g=3Da.=
nextSibling;f.appendChild(e);for(var h=3Dg;h;h=3Dg)g=3Dh.nextSibling,f.appe=
ndChild(h)}return e}
-for(;!a.nextSibling;)if(a=3Da.parentNode,!a)return;for(var a=3Db(a.nextSib=
ling,0),e;(e=3Da.parentNode)&&e.nodeType=3D=3D=3D1;)a=3De;d.push(a)}var k=
=3D/(?:^|\s)nocode(?:\s|$)/,t=3D/\r\n?|\n/,s=3Da.ownerDocument,l;a.currentS=
tyle?l=3Da.currentStyle.whiteSpace:window.getComputedStyle&&(l=3Ds.defaultV=
iew.getComputedStyle(a,q).getPropertyValue("white-space"));var p=3Dl&&"pre"=
=3D=3D=3Dl.substring(0,3);for(l=3Ds.createElement("LI");a.firstChild;)l.app=
endChild(a.firstChild);for(var d=3D[l],g=3D0;g<d.length;++g)e(d[g]);m=3D=3D=
=3D(m|0)&&d[0].setAttribute("value",
-m);var r=3Ds.createElement("OL");r.className=3D"linenums";for(var n=3DMath=
.max(0,m-1|0)||0,g=3D0,z=3Dd.length;g<z;++g)l=3Dd[g],l.className=3D"L"+(g+n=
)%10,l.firstChild||l.appendChild(s.createTextNode("\xa0")),r.appendChild(l)=
;a.appendChild(r)}function k(a,m){for(var e=3Dm.length;--e>=3D0;){var h=3Dm=
[e];A.hasOwnProperty(h)?window.console&&console.warn("cannot override langu=
age handler %s",h):A[h]=3Da}}function C(a,m){if(!a||!A.hasOwnProperty(a))a=
=3D/^\s*</.test(m)?"default-markup":"default-code";return A[a]}function E(a=
){var m=3D
-a.g;try{var e=3DM(a.h),h=3De.a;a.a=3Dh;a.c=3De.c;a.d=3D0;C(m,h)(a);var k=
=3D/\bMSIE\b/.test(navigator.userAgent),m=3D/\n/g,t=3Da.a,s=3Dt.length,e=3D=
0,l=3Da.c,p=3Dl.length,h=3D0,d=3Da.e,g=3Dd.length,a=3D0;d[g]=3Ds;var r,n;fo=
r(n=3Dr=3D0;n<g;)d[n]!=3D=3Dd[n+2]?(d[r++]=3Dd[n++],d[r++]=3Dd[n++]):n+=3D2=
;g=3Dr;for(n=3Dr=3D0;n<g;){for(var z=3Dd[n],f=3Dd[n+1],b=3Dn+2;b+2<=3Dg&&d[=
b+1]=3D=3D=3Df;)b+=3D2;d[r++]=3Dz;d[r++]=3Df;n=3Db}for(d.length=3Dr;h<p;){v=
ar o=3Dl[h+2]||s,c=3Dd[a+2]||s,b=3DMath.min(o,c),i=3Dl[h+1],j;if(i.nodeType=
!=3D=3D1&&(j=3Dt.substring(e,b))){k&&(j=3Dj.replace(m,"\r"));i.nodeValue=3D
-j;var u=3Di.ownerDocument,v=3Du.createElement("SPAN");v.className=3Dd[a+1]=
;var x=3Di.parentNode;x.replaceChild(v,i);v.appendChild(i);e<o&&(l[h+1]=3Di=
=3Du.createTextNode(t.substring(b,o)),x.insertBefore(i,v.nextSibling))}e=3D=
b;e>=3Do&&(h+=3D2);e>=3Dc&&(a+=3D2)}}catch(w){"console"in window&&console.l=
og(w&&w.stack?w.stack:w)}}var v=3D["break,continue,do,else,for,if,return,wh=
ile"],w=3D[[v,"auto,case,char,const,default,double,enum,extern,float,goto,i=
nt,long,register,short,signed,sizeof,static,struct,switch,typedef,union,uns=
igned,void,volatile"],
-"catch,class,delete,false,import,new,operator,private,protected,public,thi=
s,throw,true,try,typeof"],F=3D[w,"alignof,align_union,asm,axiom,bool,concep=
t,concept_map,const_cast,constexpr,decltype,dynamic_cast,explicit,export,fr=
iend,inline,late_check,mutable,namespace,nullptr,reinterpret_cast,static_as=
sert,static_cast,template,typeid,typename,using,virtual,where"],G=3D[w,"abs=
tract,boolean,byte,extends,final,finally,implements,import,instanceof,null,=
native,package,strictfp,super,synchronized,throws,transient"],
-H=3D[G,"as,base,by,checked,decimal,delegate,descending,dynamic,event,fixed=
,foreach,from,group,implicit,in,interface,internal,into,is,lock,object,out,=
override,orderby,params,partial,readonly,ref,sbyte,sealed,stackalloc,string=
,select,uint,ulong,unchecked,unsafe,ushort,var"],w=3D[w,"debugger,eval,expo=
rt,function,get,null,set,undefined,var,with,Infinity,NaN"],I=3D[v,"and,as,a=
ssert,class,def,del,elif,except,exec,finally,from,global,import,in,is,lambd=
a,nonlocal,not,or,pass,print,raise,try,with,yield,False,True,None"],
-J=3D[v,"alias,and,begin,case,class,def,defined,elsif,end,ensure,false,in,m=
odule,next,nil,not,or,redo,rescue,retry,self,super,then,true,undef,unless,u=
ntil,when,yield,BEGIN,END"],v=3D[v,"case,done,elif,esac,eval,fi,function,in=
,local,set,then,until"],K=3D/^(DIR|FILE|vector|(de|priority_)?queue|list|st=
ack|(const_)?iterator|(multi)?(set|map)|bitset|u?(int|float)\d*)/,N=3D/\S/,=
O=3Du({keywords:[F,H,w,"caller,delete,die,do,dump,elsif,eval,exit,foreach,f=
or,goto,if,import,last,local,my,next,no,our,print,package,redo,require,sub,=
undef,unless,until,use,wantarray,while,BEGIN,END"+
-I,J,v],hashComments:!0,cStyleComments:!0,multiLineStrings:!0,regexLiterals=
:!0}),A=3D{};k(O,["default-code"]);k(x([],[["pln",/^[^<?]+/],["dec",/^<!\w[=
^>]*(?:>|$)/],["com",/^<\!--[\S\s]*?(?:--\>|$)/],["lang-",/^<\?([\S\s]+?)(?=
:\?>|$)/],["lang-",/^<%([\S\s]+?)(?:%>|$)/],["pun",/^(?:<[%?]|[%?]>)/],["la=
ng-",/^<xmp\b[^>]*>([\S\s]+?)<\/xmp\b[^>]*>/i],["lang-js",/^<script\b[^>]*>=
([\S\s]*?)(<\/script\b[^>]*>)/i],["lang-css",/^<style\b[^>]*>([\S\s]*?)(<\/=
style\b[^>]*>)/i],["lang-in.tag",/^(<\/?[a-z][^<>]*>)/i]]),
-["default-markup","htm","html","mxml","xhtml","xml","xsl"]);k(x([["pln",/^=
\s+/,q," \t\r\n"],["atv",/^(?:"[^"]*"?|'[^']*'?)/,q,"\"'"]],[["tag",/^^<\/?=
[a-z](?:[\w-.:]*\w)?|\/?>$/i],["atn",/^(?!style[\s=3D]|on)[a-z](?:[\w:-]*\w=
)?/i],["lang-uq.val",/^=3D\s*([^\s"'>]*(?:[^\s"'/>]|\/(?=3D\s)))/],["pun",/=
^[/<->]+/],["lang-js",/^on\w+\s*=3D\s*"([^"]+)"/i],["lang-js",/^on\w+\s*=3D=
\s*'([^']+)'/i],["lang-js",/^on\w+\s*=3D\s*([^\s"'>]+)/i],["lang-css",/^sty=
le\s*=3D\s*"([^"]+)"/i],["lang-css",/^style\s*=3D\s*'([^']+)'/i],["lang-css=
",
-/^style\s*=3D\s*([^\s"'>]+)/i]]),["in.tag"]);k(x([],[["atv",/^[\S\s]+/]]),=
["uq.val"]);k(u({keywords:F,hashComments:!0,cStyleComments:!0,types:K}),["c=
","cc","cpp","cxx","cyc","m"]);k(u({keywords:"null,true,false"}),["json"]);=
k(u({keywords:H,hashComments:!0,cStyleComments:!0,verbatimStrings:!0,types:=
K}),["cs"]);k(u({keywords:G,cStyleComments:!0}),["java"]);k(u({keywords:v,h=
ashComments:!0,multiLineStrings:!0}),["bsh","csh","sh"]);k(u({keywords:I,ha=
shComments:!0,multiLineStrings:!0,tripleQuotedStrings:!0}),
-["cv","py"]);k(u({keywords:"caller,delete,die,do,dump,elsif,eval,exit,fore=
ach,for,goto,if,import,last,local,my,next,no,our,print,package,redo,require=
,sub,undef,unless,until,use,wantarray,while,BEGIN,END",hashComments:!0,mult=
iLineStrings:!0,regexLiterals:!0}),["perl","pl","pm"]);k(u({keywords:J,hash=
Comments:!0,multiLineStrings:!0,regexLiterals:!0}),["rb"]);k(u({keywords:w,=
cStyleComments:!0,regexLiterals:!0}),["js"]);k(u({keywords:"all,and,by,catc=
h,class,else,extends,false,finally,for,if,in,is,isnt,loop,new,no,not,null,o=
f,off,on,or,return,super,then,true,try,unless,until,when,while,yes",
-hashComments:3,cStyleComments:!0,multilineStrings:!0,tripleQuotedStrings:!=
0,regexLiterals:!0}),["coffee"]);k(x([],[["str",/^[\S\s]+/]]),["regex"]);wi=
ndow.prettyPrintOne=3Dfunction(a,m,e){var h=3Ddocument.createElement("PRE")=
;h.innerHTML=3Da;e&&D(h,e);E({g:m,i:e,h:h});return h.innerHTML};window.pret=
tyPrint=3Dfunction(a){function m(){for(var e=3Dwindow.PR_SHOULD_USE_CONTINU=
ATION?l.now()+250:Infinity;p<h.length&&l.now()<e;p++){var n=3Dh[p],k=3Dn.cl=
assName;if(k.indexOf("prettyprint")>=3D0){var k=3Dk.match(g),f,b;if(b=3D
-!k){b=3Dn;for(var o=3Dvoid 0,c=3Db.firstChild;c;c=3Dc.nextSibling)var i=3D=
c.nodeType,o=3Di=3D=3D=3D1?o?b:c:i=3D=3D=3D3?N.test(c.nodeValue)?b:o:o;b=3D=
(f=3Do=3D=3D=3Db?void 0:o)&&"CODE"=3D=3D=3Df.tagName}b&&(k=3Df.className.ma=
tch(g));k&&(k=3Dk[1]);b=3D!1;for(o=3Dn.parentNode;o;o=3Do.parentNode)if((o.=
tagName=3D=3D=3D"pre"||o.tagName=3D=3D=3D"code"||o.tagName=3D=3D=3D"xmp")&&=
o.className&&o.className.indexOf("prettyprint")>=3D0){b=3D!0;break}b||((b=
=3D(b=3Dn.className.match(/\blinenums\b(?::(\d+))?/))?b[1]&&b[1].length?+b[=
1]:!0:!1)&&D(n,b),d=3D{g:k,h:n,i:b},E(d))}}p<h.length?setTimeout(m,
-250):a&&a()}for(var e=3D[document.getElementsByTagName("pre"),document.get=
ElementsByTagName("code"),document.getElementsByTagName("xmp")],h=3D[],k=3D=
0;k<e.length;++k)for(var t=3D0,s=3De[k].length;t<s;++t)h.push(e[k][t]);var =
e=3Dq,l=3DDate;l.now||(l=3D{now:function(){return+new Date}});var p=3D0,d,g=
=3D/\blang(?:uage)?-([\w.]+)(?!\S)/;m()};window.PR=3D{createSimpleLexer:x,r=
egisterLangHandler:k,sourceDecorator:u,PR_ATTRIB_NAME:"atn",PR_ATTRIB_VALUE=
:"atv",PR_COMMENT:"com",PR_DECLARATION:"dec",PR_KEYWORD:"kwd",PR_LITERAL:"l=
it",
-PR_NOCODE:"nocode",PR_PLAIN:"pln",PR_PUNCTUATION:"pun",PR_SOURCE:"src",PR_=
STRING:"str",PR_TAG:"tag",PR_TYPE:"typ"}})();
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toast=
ergui/templates/base.html
index 0fbe17b..edbd110 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -24,7 +24,7 @@
     </script>
     <script src=3D"{% static 'js/jsrender.min.js' %}">
     </script>
-    <script src=3D"{% static 'js/prettify.js' %}">
+    <script src=3D"{% static 'js/highlight.pack.js' %}">
     </script>
     <script src=3D"{% static 'js/libtoaster.js' %}">
     </script>
diff --git a/lib/toaster/toastergui/templates/js-unit-tests.html b/lib/toas=
ter/toastergui/templates/js-unit-tests.html
index 94ad4f8..ca24896 100644
--- a/lib/toaster/toastergui/templates/js-unit-tests.html
+++ b/lib/toaster/toastergui/templates/js-unit-tests.html
@@ -14,7 +14,7 @@
 <script src=3D"{% static 'js/bootstrap.min.js' %}"></script>
 <script src=3D"{% static 'js/filtersnippet.js' %}"></script>
 <script src=3D"{% static 'js/importlayer.js' %}"></script>
-<script src=3D"{% static 'js/prettify.js' %}"></script>
+<script src=3D"{% static 'js/highlight.pack.js' %}"></script>
 <script src=3D"{% static 'js/layerBtn.js' %}"></script>
 <script src=3D"{% static 'js/layerDepsModal.js' %}"></script>
 <script src=3D"{% static 'js/projectpage.js' %}"></script>
--=20
1.9.1


