Return-Path: <chanm@cisco.com>
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	by mail.openembedded.org (Postfix) with ESMTP id DFA22601AF
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Jun 2013 18:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=cisco.com; i=@cisco.com; l=5086; q=dns/txt; s=iport;
	t=1370457998; x=1371667598;
	h=from:to:subject:date:message-id:mime-version;
	bh=Hix+WUaAE4hjvaURlr+yl09EGKJflkyr191tyd/Q+Dw=;
	b=RZ3SXfDijbLT2h6W29IbmA0a9Yk90VxyYg34FOsEawBofryb+LW/Z9Z2
	ewBd5QOORRUDx3GTR5fPGP2JwXKvMVDSFVu7hyiWoljHl7i/RMRF4RrPy
	UqY8JkGCp8U8SUOp1ahZYK9hohKy4NbcnI5uB5ISVEX4adZUmKiEe+vEy 4=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkwFAJmGr1GtJV2a/2dsb2JhbABZgkVEML8xfxZtB4IlAQRrIAEMHlYnBBuIBQydKaA5jnotgwVhA5hokBeDD4In
X-IronPort-AV: E=Sophos;i="4.87,809,1363132800"; 
	d="scan'208,217";a="219240485"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
	by rcdn-iport-5.cisco.com with ESMTP; 05 Jun 2013 18:46:37 +0000
Received: from xhc-rcd-x15.cisco.com (xhc-rcd-x15.cisco.com [173.37.183.89])
	by rcdn-core-3.cisco.com (8.14.5/8.14.5) with ESMTP id r55IkbIJ019042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Wed, 5 Jun 2013 18:46:37 GMT
Received: from xmb-rcd-x07.cisco.com ([169.254.7.39]) by xhc-rcd-x15.cisco.com
	([173.37.183.89]) with mapi id 14.02.0318.004;
	Wed, 5 Jun 2013 13:46:36 -0500
From: "Ming Chan (chanm)" <chanm@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Question on including ruby 1.9.3 in embedded image
Thread-Index: AQHOYh0B2KchihXKtkuouOrjdJbvuQ==
Date: Wed, 5 Jun 2013 18:46:36 +0000
Message-ID: <A8108027F6475848B4BB89A74BA7AE4319386579@xmb-rcd-x07.cisco.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.3.4.130416
x-originating-ip: [10.131.36.235]
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 05 Jun 2013 21:15:22 +0000
Subject: Question on including ruby 1.9.3 in embedded image
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 05 Jun 2013 18:46:37 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_A8108027F6475848B4BB89A74BA7AE4319386579xmbrcdx07ciscoc_"

--_000_A8108027F6475848B4BB89A74BA7AE4319386579xmbrcdx07ciscoc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Experts,

We are trying to include ruby-1.9.3 by using the recipe in the meta-openemb=
edded/meta-ruby (git://git.openembedded.org/meta-openembedded), Issues seen=
 during the bitbake run:

  1.  While package ruby-native-1.9.3-p194-r1.0, task do_compile failed wit=
h "undefined symbol: rb_encdb_declare<https://www.google.com/url?sa=3Dt&rct=
=3Dj&q=3D&esrc=3Ds&source=3Dweb&cd=3D6&ved=3D0CFAQFjAF&url=3Dhttp%3A%2F%2Fr=
edcricketblog.blogspot.com%2F2012%2F11%2Fundefined-symbol-rbencdbdeclare-wh=
en.html&ei=3DpweuUfKeAo-84APUmIDYBw&usg=3DAFQjCNHuVyAc5etRS6QWb_2pZ-ow76TXV=
Q&sig2=3DUY_7YNA1ozt7odj4q2tljA&bvm=3Dbv.47244034,d.dmg>", the work around =
this issue is to use --disable-rdoc
  2.  While package ruby-1.9.3-p194-r1.0, task do_compile failed with the f=
ollowing:
     *
template/Doxyfile.tmpl:22: uninitialized constant RUBY_REVISION (NameError)=
.  The work around is to use 0 instead of RUBY_REVISION.
     *   executable host ruby is required.  The work around is to use --wit=
h-baseruby option and provide baseruby from build machine.
     *   ext/etc/extconf.rb:8: undefined method `escape' for Shellwords.  T=
his issue is caused by the version of executable host ruby is to old.  This=
 issue disappeared after using ruby-1.8.7 on the build machine.
     *   The current issue is "../.././lib/erb.rb:586:in `compile': undefin=
ed method `encoding' for
#<String:0x2a9560fee0> (NoMethodError)"

Does it make sense for the work around described?  Any requirement (i.e. Th=
e version of gcc) is needed to use  the recipe in the meta-openembedded/met=
a-ruby?


Thanks in advance !!!

--Ming

--_000_A8108027F6475848B4BB89A74BA7AE4319386579xmbrcdx07ciscoc_
Content-Type: text/html; charset="us-ascii"
Content-ID: <BD377C2B20E0724FA79BD8CD5C7A2A9C@emea.cisco.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space; ">
<div style=3D"color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-s=
ize: 14px; ">
Hi Experts,&nbsp;</div>
<div style=3D"color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-s=
ize: 14px; ">
<br>
</div>
<div><font face=3D"Calibri,sans-serif">We are trying to include ruby-1.9.3 =
by using the recipe in the</font>&nbsp;<span style=3D"color: rgb(0, 0, 0); =
font-size: medium; ">meta-openembedded/meta-ruby
</span><span style=3D"color: rgb(0, 0, 0); font-size: medium; ">(</span>git=
://git.openembedded.org/meta-openembedded), Issues seen during the bitbake =
run:</div>
<ol>
<li>While package&nbsp;ruby-native-1.9.3-p194-r1.0, task do_compile failed =
with &quot;<a href=3D"https://www.google.com/url?sa=3Dt&amp;rct=3Dj&amp;q=
=3D&amp;esrc=3Ds&amp;source=3Dweb&amp;cd=3D6&amp;ved=3D0CFAQFjAF&amp;url=3D=
http%3A%2F%2Fredcricketblog.blogspot.com%2F2012%2F11%2Fundefined-symbol-rbe=
ncdbdeclare-when.html&amp;ei=3DpweuUfKeAo-84APUmIDYBw&amp;usg=3DAFQjCNHuVyA=
c5etRS6QWb_2pZ-ow76TXVQ&amp;sig2=3DUY_7YNA1ozt7odj4q2tljA&amp;bvm=3Dbv.4724=
4034,d.dmg" style=3D"text-align: left; white-space: nowrap; color: rgb(17, =
34, 204); cursor: pointer; "><font color=3D"#1122cc"><span style=3D"text-al=
ign: left; white-space: nowrap; cursor: pointer; ">undefined
 symbol:&nbsp;</span></font><em style=3D"text-align: left; white-space: now=
rap; color: rgb(17, 34, 204); cursor: pointer; font-weight: bold; font-styl=
e: normal; ">rb_encdb_declare</em></a>&quot;, the work around this issue is=
 to use --disable-rdoc&nbsp;</li><li>While package&nbsp;ruby-1.9.3-p194-r1.=
0, task do_compile failed with the following:
<ul>
<li>
<div>template/Doxyfile.tmpl:22: uninitialized constant RUBY_REVISION&nbsp;(=
NameError). &nbsp;The work around is to use 0 instead of&nbsp;RUBY_REVISION=
.</div>
</li><li>executable host ruby is required. &nbsp;The work around is to use =
--with-baseruby option and provide&nbsp;baseruby from build machine.</li><l=
i>ext/etc/extconf.rb:8: undefined method `escape' for Shellwords. &nbsp;Thi=
s issue is caused by the version of executable host ruby is to old. &nbsp;T=
his issue disappeared after using ruby-1.8.7 on the build machine.</li><li>=
The current issue is &quot;../.././lib/erb.rb:586:in `compile': undefined m=
ethod `encoding'&nbsp;for
<div>#&lt;String:0x2a9560fee0&gt; (NoMethodError)&quot;</div>
</li></ul>
</li></ol>
<div>Does it make sense for the work around described? &nbsp;Any requiremen=
t (i.e. The version of gcc) is needed to use &nbsp;t<font face=3D"Calibri,s=
ans-serif">he recipe in the</font>&nbsp;meta-openembedded/meta-ruby?&nbsp;<=
/div>
<div><br>
</div>
<div><br>
</div>
<div>Thanks in advance !!!</div>
<div><br>
</div>
<div>--Ming</div>
</body>
</html>

--_000_A8108027F6475848B4BB89A74BA7AE4319386579xmbrcdx07ciscoc_--
