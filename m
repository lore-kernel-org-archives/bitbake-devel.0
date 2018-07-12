Return-Path: <developer_agl@xtev.cn>
X-Greylist: delayed 425 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 12 Jul 2018 10:16:43 UTC
Received: from smtpbg328.qq.com (smtpbg328.qq.com [14.17.43.160])
	by mail.openembedded.org (Postfix) with ESMTP id 079A5745F4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 10:16:43 +0000 (UTC)
X-QQ-mid: bizesmtp10t1531390148tza1zpa6
Received: from albertPC (unknown [106.39.114.134])
	by esmtp10.qq.com (ESMTP) with SMTP id 0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 18:09:07 +0800 (CST)
X-QQ-SSF: 01400000000000504330B00A0000000
X-QQ-FEAT: aS6NN6UIZfl3xvo8fe9fKYK9Iee2w8ovHspgxvywKvXrzqXt5tfekLVaJ9U9q
	G0dLadp7Fqlng0AHkwoTCfZAa86Gggxpe4EKja3hXJyDa2Af2lWDvXyqZgwqG3mjcFwbFPm
	kgDxsU3aZOB6N5gt7lOtvjSVMdVJ2s/CnNZ2pYXaZSl66/cdEvyvQ2EPVJqB6z0qmd3Qyt+
	w8IyEf4gWuYZNstNZFfMKuB96p8SEc8AEU4PMckXCZW4LPf9mQ2k5UGnzYjM/9m21fgU+le
	O0qH/ZXd9+ajk77cuvQy1iXPdVvgmFQIht75sVMl+z8EgQ
X-QQ-GoodBg: 2
From: <developer_agl@xtev.cn>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Jul 2018 18:09:08 +0800
Message-ID: <008101d419c8$5fc58200$1f508600$@xtev.cn>+A632A221EAA36C67
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdQZxevRTfvWy0k3TSOwyrqDNf1zrA==
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:xtev.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Subject: About bitbake tasks
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
X-List-Received-Date: Thu, 12 Jul 2018 10:16:44 -0000
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0082_01D41A0B.6DE91020"
Content-Language: zh-cn

------=_NextPart_000_0082_01D41A0B.6DE91020
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I'm new to bitbake. And I have some questions about bitbake tasks mechanism
and inherit mechanism. If a xxx.bb recipe content like this :

 

##start

DESCRIPTION = "xxxxxxxxx"

 

XXX_XXXX = "${XXXXXXXX}"

 

require some_guys 

##end

 

And Bitbake User Manual said that 'The minimally required class for BitBake
is the classes/base.bbclass file. The base class is implicitly inherited by
every recipe.' So which .bbclass should be parsed first, some_guys.bbclass
or base.bbclass? I'm really confused about that.

 

 

 

 

 

 

Thanks.

 


------=_NextPart_000_0082_01D41A0B.6DE91020
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
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
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:DengXian;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-CN =
link=3D"#0563C1" vlink=3D"#954F72" =
style=3D'text-justify-trim:punctuation'><div class=3DWordSection1><p =
class=3DMsoNormal><span lang=3DEN-US>Hi,<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>I&#8217;m new to bitbake. And I =
have some questions about bitbake tasks mechanism and inherit mechanism. =
If a xxx.bb recipe content like this :<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>##start<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>DESCRIPTION =3D =
&#8221;xxxxxxxxx&#8221;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>XXX_XXXX =3D =
&#8220;${XXXXXXXX}&#8221;<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>require some_guys =
<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>##end<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>And Bitbake User Manual said that &#8216;<span =
style=3D'color:red'>The minimally required class for BitBake is the =
classes/base.bbclass file. The base class is implicitly inherited by =
every recipe.</span>&#8217; So which .bbclass should be parsed first, =
some_guys.bbclass or base.bbclass? I&#8217;m really confused about =
that.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Thanks.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div></body></html>

------=_NextPart_000_0082_01D41A0B.6DE91020--
