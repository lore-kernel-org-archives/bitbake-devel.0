Return-Path: <luwei.zhou@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id EBBED71957
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Mar 2016 08:32:11 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 18 Mar 2016 01:32:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,354,1455004800"; 
	d="scan'208,217";a="913730506"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
	by orsmga001.jf.intel.com with ESMTP; 18 Mar 2016 01:32:11 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
	FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server
	(TLS) id 14.3.248.2; Fri, 18 Mar 2016 01:32:07 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.110.15) by
	FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server
	(TLS) id 14.3.248.2; Fri, 18 Mar 2016 01:32:06 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.232]) by
	SHSMSX104.ccr.corp.intel.com ([169.254.5.132]) with mapi id
	14.03.0248.002; Fri, 18 Mar 2016 16:32:05 +0800
From: "Zhou, Luwei" <luwei.zhou@intel.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: bitbake fetching fails on git repo but can manually git clone
Thread-Index: AdGA8HK+YBuIHIPMRrK6eGXezUOV3Q==
Date: Fri, 18 Mar 2016 08:32:04 +0000
Message-ID: <46BA6A9193234D4CB7051E63F3A63ED52DF9AE@shsmsx102.ccr.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: bitbake fetching fails on git repo but can manually git clone
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
X-List-Received-Date: Fri, 18 Mar 2016 08:32:14 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_46BA6A9193234D4CB7051E63F3A63ED52DF9AEshsmsx102ccrcorpi_"

--_000_46BA6A9193234D4CB7051E63F3A63ED52DF9AEshsmsx102ccrcorpi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all

I am new to yocto and hope the mail list is the right place to ask.

I am using jethro 2.0 to build my yocto system. I have met some weird issue=
 when bitbake fetching source. When I try bitbake image, there would be fet=
ching error caused by some components(mraa etc). I have tried enabling -D o=
ption when running bitbake -D mraa -c fetch to see the log.  I can see bitb=
ake will first trying using git clone to fetch the code and failed(with a r=
eturn of warning) and then trying mirror still failed with error. However, =
When I manually run the command  below:

git -c core.fsyncobjectfiles=3D0 clone --bare --mirror git://github.com/int=
el-iot-devkit/mraa.git /home/luweizho/build/ambr-yocto-build/build/download=
s/git2/github.com.intel-iot-devkit.mraa.git

The git clone can be completed. My current setting is below. It is kind of =
weird.  Why git clone can work manually but bitbake fetching would return w=
arning and then fail. I have checked the wiki below and didn't find out the=
 reason.
https://wiki.yoctoproject.org/wiki/Working_Behind_a_Network_Proxy


My ~/.bashrc proxy settingis:

export SOCKS_SERVER=3Dproxy-png.intel.com
export HTTP_PROXY=3Dhttp://proxy-chain.intel.com:911
export HTTPS_PROXY=3Dhttps://proxy-chain.intel.com:912
export HTTP_DIRECT=3Dintel.com,.intel.com,10.0.0.0/8,192.168.0.0/16,localho=
st,127.0.0.0/8,134.134.0.0/16
export FTP_PROXY=3D$HTTP_PROXY
export ftp_proxy=3D$HTTP_PROXY
export http_proxy=3D$HTTP_PROXY
export https_proxy=3D$HTTPS_PROXY
export NO_PROXY=3D$HTTP_DIRECT
export no_proxy=3D$NO_PROXY
export GIT_PROXY_COMMAND=3D/home/luweizho/tool/gitproxy.sh

luweizho@pglvm2014-v03:~/build/ambr-yocto-build/build$ cat ~/tool/gitproxy.=
sh
#!/bin/sh
exec socat stdio SOCKS:$SOCKS_SERVER:$1:$2


The following is the warning message when running bitbake -D mraa -c fetch.=
 After the warning, bitbake would try the mirror link by http and fails.

DEBUG: Fetcher accessed the network with the command git -c core.fsyncobjec=
tfiles=3D0 clone --bare --mirror git://github.com/intel-iot-devkit/mraa.git=
 /home/luweizho/build/ambr-yocto-build/build/downloads/git2/github.com.inte=
l-iot-devkit.mraa.git
DEBUG: Running export no_proxy=3D"intel.com,.intel.com,10.0.0.0/8,192.168.0=
.0/16,localhost,127.0.0.0/8,134.134.0.0/16"; export NO_PROXY=3D"intel.com,.=
intel.com,10.0.0.0/8,192.168.0.0/16,localhost,127.0.0.0/8,134.134.0.0/16"; =
export ftp_proxy=3D"http://proxy-chain.intel.com:911"; export FTP_PROXY=3D"=
http://proxy-chain.intel.com:911"; export https_proxy=3D"https://proxy-chai=
n.intel.com:912"; export HTTPS_PROXY=3D"https://proxy-chain.intel.com:912";=
 export http_proxy=3D"http://proxy-chain.intel.com:911"; export HTTP_PROXY=
=3D"http://proxy-chain.intel.com:911"; export PATH=3D"/home/luweizho/build/=
ambr-yocto-build/build/tmp/sysroots/x86_64-linux/usr/bin/python-native:/hom=
e/luweizho/build/ambr-yocto-build/scripts:/home/luweizho/build/ambr-yocto-b=
uild/build/tmp/sysroots/x86_64-linux/usr/bin/x86_64-poky-linux:/home/luweiz=
ho/build/ambr-yocto-build/build/tmp/sysroots/intel-corei7-64/usr/bin/crosss=
cripts:/home/luweizho/build/ambr-yocto-build/build/tmp/sysroots/x86_64-linu=
x/usr/sbin:/home/luweizho/build/ambr-yocto-build/build/tmp/sysroots/x86_64-=
linux/usr/bin:/home/luweizho/build/ambr-yocto-build/build/tmp/sysroots/x86_=
64-linux/sbin:/home/luweizho/build/ambr-yocto-build/build/tmp/sysroots/x86_=
64-linux/bin:/home/luweizho/build/ambr-yocto-build/scripts:/home/luweizho/b=
uild/ambr-yocto-build/bitbake/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:=
/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"; export HOME=3D"/home/luwe=
izho"; git -c core.fsyncobjectfiles=3D0 clone --bare --mirror git://github.=
com/intel-iot-devkit/mraa.git /home/luweizho/build/ambr-yocto-build/build/d=
ownloads/git2/github.com.intel-iot-devkit.mraa.git
WARNING: Failed to fetch URL git://github.com/intel-iot-devkit/mraa.git;pro=
tocol=3Dgit;rev=3Dba5318fee92e63e1481ad1392ec56e7a6ebaf4fe, attempting MIRR=
ORS if available

Best Regards
Luwei



--_000_46BA6A9193234D4CB7051E63F3A63ED52DF9AEshsmsx102ccrcorpi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Hi all<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I am new to yocto and =
hope the mail list is the right place to ask.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I am using jethro 2.0 =
to build my yocto system. I have met some weird issue when bitbake fetching=
 source. When I try bitbake image, there would be fetching error caused by =
some components(mraa etc). I have tried
 enabling &#8211;D option when running bitbake -D mraa -c fetch to see the =
log.&nbsp; I can see bitbake will first trying using git clone to fetch the=
 code and failed(with a return of warning) and then trying mirror still fai=
led with error. However, When I manually run
 the command&nbsp; below:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">gi=
t -c core.fsyncobjectfiles=3D0 clone --bare --mirror git://github.com/intel=
-iot-devkit/mraa.git /home/luweizho/build/ambr-yocto-build/build/downloads/=
git2/github.com.intel-iot-devkit.mraa.git<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D"><o=
:p>&nbsp;</o:p></span></b></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">The git clone can be c=
ompleted. My current setting is below. It is kind of weird. &nbsp;Why git c=
lone can work manually but bitbake fetching would return warning and then f=
ail. I have checked the wiki below and didn&#8217;t
 find out the reason.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><a href=3D"https://wik=
i.yoctoproject.org/wiki/Working_Behind_a_Network_Proxy"><span style=3D"colo=
r:#0563C1">https://wiki.yoctoproject.org/wiki/Working_Behind_a_Network_Prox=
y</span></a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">My ~/.bashrc proxy set=
tingis:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
port SOCKS_SERVER=3Dproxy-png.intel.com<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
port HTTP_PROXY=3Dhttp://proxy-chain.intel.com:911<o:p></o:p></span></b></p=
>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
port HTTPS_PROXY=3Dhttps://proxy-chain.intel.com:912<o:p></o:p></span></b><=
/p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
port HTTP_DIRECT=3Dintel.com,.intel.com,10.0.0.0/8,192.168.0.0/16,localhost=
,127.0.0.0/8,134.134.0.0/16<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
port FTP_PROXY=3D$HTTP_PROXY<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
port ftp_proxy=3D$HTTP_PROXY<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
port http_proxy=3D$HTTP_PROXY<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
port https_proxy=3D$HTTPS_PROXY<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
port NO_PROXY=3D$HTTP_DIRECT<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
port no_proxy=3D$NO_PROXY<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
port GIT_PROXY_COMMAND=3D/home/luweizho/tool/gitproxy.sh<o:p></o:p></span><=
/b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D"><o=
:p>&nbsp;</o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">lu=
weizho@pglvm2014-v03:~/build/ambr-yocto-build/build$ cat ~/tool/gitproxy.sh=
<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">#!=
/bin/sh<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D">ex=
ec socat stdio SOCKS:$SOCKS_SERVER:$1:$2<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#1F497D"><o=
:p>&nbsp;</o:p></span></b></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">The following is the w=
arning message when running bitbake -D mraa -c fetch. After the warning, bi=
tbake would try the mirror link by http and fails.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;color:#1F497D">DEBUG:=
 Fetcher accessed the network with the command
</span><span style=3D"font-size:9.0pt;color:red">git -c core.fsyncobjectfil=
es=3D0 clone --bare --mirror git://github.com/intel-iot-devkit/mraa.git</sp=
an><span style=3D"font-size:9.0pt;color:#1F497D"> /home/luweizho/build/ambr=
-yocto-build/build/downloads/git2/github.com.intel-iot-devkit.mraa.git<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;color:#1F497D">DEBUG:=
 </span><span style=3D"font-size:9.0pt;color:red">Running export no_proxy=
=3D&quot;intel.com,.intel.com,10.0.0.0/8,192.168.0.0/16,localhost,127.0.0.0=
/8,134.134.0.0/16&quot;; export NO_PROXY=3D&quot;intel.com,.intel.com,10.0.=
0.0/8,192.168.0.0/16,localhost,127.0.0.0/8,134.134.0.0/16&quot;;
 export ftp_proxy=3D&quot;<a href=3D"http://proxy-chain.intel.com:911"><spa=
n style=3D"color:#0563C1">http://proxy-chain.intel.com:911</span></a>&quot;=
; export FTP_PROXY=3D&quot;<a href=3D"http://proxy-chain.intel.com:911"><sp=
an style=3D"color:#0563C1">http://proxy-chain.intel.com:911</span></a>&quot=
;;
 export https_proxy=3D&quot;<a href=3D"https://proxy-chain.intel.com:912"><=
span style=3D"color:#0563C1">https://proxy-chain.intel.com:912</span></a>&q=
uot;; export HTTPS_PROXY=3D&quot;<a href=3D"https://proxy-chain.intel.com:9=
12"><span style=3D"color:#0563C1">https://proxy-chain.intel.com:912</span><=
/a>&quot;;
 export http_proxy=3D&quot;<a href=3D"http://proxy-chain.intel.com:911"><sp=
an style=3D"color:#0563C1">http://proxy-chain.intel.com:911</span></a>&quot=
;; export HTTP_PROXY=3D&quot;<a href=3D"http://proxy-chain.intel.com:911"><=
span style=3D"color:#0563C1">http://proxy-chain.intel.com:911</span></a>&qu=
ot;;
 export PATH=3D&quot;/home/luweizho/build/ambr-yocto-build/build/tmp/sysroo=
ts/x86_64-linux/usr/bin/python-native:/home/luweizho/build/ambr-yocto-build=
/scripts:/home/luweizho/build/ambr-yocto-build/build/tmp/sysroots/x86_64-li=
nux/usr/bin/x86_64-poky-linux:/home/luweizho/build/ambr-yocto-build/build/t=
mp/sysroots/intel-corei7-64/usr/bin/crossscripts:/home/luweizho/build/ambr-=
yocto-build/build/tmp/sysroots/x86_64-linux/usr/sbin:/home/luweizho/build/a=
mbr-yocto-build/build/tmp/sysroots/x86_64-linux/usr/bin:/home/luweizho/buil=
d/ambr-yocto-build/build/tmp/sysroots/x86_64-linux/sbin:/home/luweizho/buil=
d/ambr-yocto-build/build/tmp/sysroots/x86_64-linux/bin:/home/luweizho/build=
/ambr-yocto-build/scripts:/home/luweizho/build/ambr-yocto-build/bitbake/bin=
:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/u=
sr/local/games&quot;;
 export HOME=3D&quot;/home/luweizho&quot;; git -c core.fsyncobjectfiles=3D0=
 clone --bare --mirror git://github.com/intel-iot-devkit/mraa.git /home/luw=
eizho/build/ambr-yocto-build/build/downloads/git2/github.com.intel-iot-devk=
it.mraa.git<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;color:#1F497D">WARNIN=
G: Failed to fetch URL git://github.com/intel-iot-devkit/mraa.git;protocol=
=3Dgit;rev=3Dba5318fee92e63e1481ad1392ec56e7a6ebaf4fe, attempting MIRRORS i=
f available<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><a name=3D"_MailEndCompose"><span style=3D"color:#1F=
497D">Best Regards</span></a><span style=3D"color:#1F497D"><o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Luwei<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_46BA6A9193234D4CB7051E63F3A63ED52DF9AEshsmsx102ccrcorpi_--
