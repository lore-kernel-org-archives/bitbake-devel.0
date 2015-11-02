Return-Path: <Gabriel.Almeida@harman.com>
X-Greylist: delayed 428 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 02 Nov 2015 08:30:00 UTC
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
	[193.109.254.110])
	by mail.openembedded.org (Postfix) with ESMTP id 9133360232
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Nov 2015 08:30:00 +0000 (UTC)
Received: from [85.158.140.195] by server-6.bemta-14.messagelabs.com id
	92/B4-16618-A5D17365; Mon, 02 Nov 2015 08:22:50 +0000
X-Env-Sender: Gabriel.Almeida@harman.com
X-Msg-Ref: server-2.tower-193.messagelabs.com!1446452569!1286663!1
X-Originating-IP: [194.121.90.173]
X-StarScan-Received: 
X-StarScan-Version: 7.19.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20209 invoked from network); 2 Nov 2015 08:22:49 -0000
Received: from unassigned (HELO HIKAWSEXHC03.ad.harman.com) (194.121.90.173)
	by server-2.tower-193.messagelabs.com with AES128-SHA encrypted SMTP;
	2 Nov 2015 08:22:49 -0000
Received: from HIKAWSEXMB01.ad.harman.com ([169.254.1.95]) by
	HIKAWSEXHC03.ad.harman.com ([172.16.1.113]) with mapi id 14.03.0235.001;
	Mon, 2 Nov 2015 09:22:48 +0100
From: "Almeida, Gabriel" <Gabriel.Almeida@harman.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Help 
Thread-Index: AdEVR6f2uUCfJWJMSfmVrvktDcpYZQ==
Date: Mon, 2 Nov 2015 08:22:47 +0000
Message-ID: <B267CE46C9DC3C4BB251EC9C004EA5661A6925C3@HIKAWSEXMB01.ad.harman.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.57.151]
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 02 Nov 2015 16:59:59 +0000
Subject: Help
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
X-List-Received-Date: Mon, 02 Nov 2015 08:30:03 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_B267CE46C9DC3C4BB251EC9C004EA5661A6925C3HIKAWSEXMB01adh_"

--_000_B267CE46C9DC3C4BB251EC9C004EA5661A6925C3HIKAWSEXMB01adh_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello there,

I want to setup toaster on my VM and I have followed the steps up to (3.1.1=
 - Step 5):
https://www.yoctoproject.org/docs/1.9/toaster-manual/toaster-manual.html#se=
tting-up-locally-and-running-in-analysis-mode

Where I got the following error...

Toaster is already running and I am able to access it over the web (localho=
st:8000), however while bitbaking, I am getting the following error:

```
(venv)yoctoadm@kickseed:~/poky/build (fido)*$ bitbake core-image-minimal
Traceback (most recent call last):
  File "/home/yoctoadm/poky/bitbake/bin/bitbake", line 41, in <module>
    cookerdata.CookerConfiguration())
  File "/home/yoctoadm/poky/bitbake/lib/bb/main.py", line 383, in bitbake_m=
ain
    return ui_module.main(server_connection.connection, server_connection.e=
vents, configParams)
  File "/home/yoctoadm/poky/bitbake/lib/bb/ui/knotty.py", line 287, in main
    params.updateToServer(server, os.environ.copy())
  File "/home/yoctoadm/poky/bitbake/lib/bb/cookerdata.py", line 79, in upda=
teToServer
    ret, error =3D server.runCommand(["updateConfig", options, environment]=
)
  File "/usr/lib/python2.7/xmlrpclib.py", line 1233, in __call__
    return self.__send(self.__name, args)
  File "/usr/lib/python2.7/xmlrpclib.py", line 1587, in __request
    verbose=3Dself.__verbose
  File "/usr/lib/python2.7/xmlrpclib.py", line 1273, in request
    return self.single_request(host, handler, request_body, verbose)
  File "/usr/lib/python2.7/xmlrpclib.py", line 1306, in single_request
    return self.parse_response(response)
  File "/usr/lib/python2.7/xmlrpclib.py", line 1482, in parse_response
    return u.close()
  File "/usr/lib/python2.7/xmlrpclib.py", line 794, in close
    raise Fault(**self._stack[0])
Fault: <Fault 1: "<class 'xml.parsers.expat.ExpatError'>:not well-formed (i=
nvalid token): line 115, column 120">
```

```
(venv)yoctoadm@kickseed:~/poky/build (fido)*$

BitBake Build Tool Core version 1.26.0, bitbake version 1.26.0
```

BR
Gabriel




--_000_B267CE46C9DC3C4BB251EC9C004EA5661A6925C3HIKAWSEXMB01adh_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Hello there,<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I want to setup toaste=
r on my VM and I have followed the steps up to (3.1.1 - Step 5):<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">https://www.yoctoproje=
ct.org/docs/1.9/toaster-manual/toaster-manual.html#setting-up-locally-and-r=
unning-in-analysis-mode<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Where I got the follow=
ing error...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Toaster is already run=
ning and I am able to access it over the web (localhost:8000), however whil=
e bitbaking, I am getting the following error:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">```<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">(venv)yoctoadm@kicksee=
d:~/poky/build (fido)*$ bitbake core-image-minimal<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Traceback (most recent=
 call last):<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp; File &quot;/hom=
e/yoctoadm/poky/bitbake/bin/bitbake&quot;, line 41, in &lt;module&gt;<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp; coo=
kerdata.CookerConfiguration())<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp; File &quot;/hom=
e/yoctoadm/poky/bitbake/lib/bb/main.py&quot;, line 383, in bitbake_main<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp; ret=
urn ui_module.main(server_connection.connection, server_connection.events, =
configParams)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp; File &quot;/hom=
e/yoctoadm/poky/bitbake/lib/bb/ui/knotty.py&quot;, line 287, in main<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp; par=
ams.updateToServer(server, os.environ.copy())<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp; File &quot;/hom=
e/yoctoadm/poky/bitbake/lib/bb/cookerdata.py&quot;, line 79, in updateToSer=
ver<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp; ret=
, error =3D server.runCommand([&quot;updateConfig&quot;, options, environme=
nt])<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp; File &quot;/usr=
/lib/python2.7/xmlrpclib.py&quot;, line 1233, in __call__<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp; ret=
urn self.__send(self.__name, args)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp; File &quot;/usr=
/lib/python2.7/xmlrpclib.py&quot;, line 1587, in __request<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp; ver=
bose=3Dself.__verbose<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp; File &quot;/usr=
/lib/python2.7/xmlrpclib.py&quot;, line 1273, in request<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp; ret=
urn self.single_request(host, handler, request_body, verbose)<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp; File &quot;/usr=
/lib/python2.7/xmlrpclib.py&quot;, line 1306, in single_request<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp; ret=
urn self.parse_response(response)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp; File &quot;/usr=
/lib/python2.7/xmlrpclib.py&quot;, line 1482, in parse_response<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp; ret=
urn u.close()<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp; File &quot;/usr=
/lib/python2.7/xmlrpclib.py&quot;, line 794, in close<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp; rai=
se Fault(**self._stack[0])<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Fault: &lt;Fault 1: &q=
uot;&lt;class 'xml.parsers.expat.ExpatError'&gt;:not well-formed (invalid t=
oken): line 115, column 120&quot;&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">```<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">```<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">(venv)yoctoadm@kicksee=
d:~/poky/build (fido)*$
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">BitBake Build Tool Cor=
e version 1.26.0, bitbake version 1.26.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">```<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">BR<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Gabriel<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_B267CE46C9DC3C4BB251EC9C004EA5661A6925C3HIKAWSEXMB01adh_--
