Received: from mail1.bemta8.messagelabs.com ([216.82.243.200])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Simon.Vanveerdeghem@barco.com>) id 1UQXxn-0006vK-Pk
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Apr 2013 09:00:08 +0200
Received: from [216.82.241.132:35233] by server-8.bemta-8.messagelabs.com id
	76/C2-19818-66BA7615; Fri, 12 Apr 2013 06:36:22 +0000
X-Env-Sender: Simon.Vanveerdeghem@barco.com
X-Msg-Ref: server-13.tower-45.messagelabs.com!1365748580!29021377!3
X-Originating-IP: [91.183.168.164]
X-StarScan-Received: 
X-StarScan-Version: 6.8.6.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19091 invoked from network); 12 Apr 2013 06:36:22 -0000
Received: from 164.168-183-91.adsl-static.isp.belgacom.be (HELO
	KNDFEX01.barco.com) (91.183.168.164)
	by server-13.tower-45.messagelabs.com with SMTP;
	12 Apr 2013 06:36:22 -0000
Received: from KNDMEX01.barco.com ([150.158.212.51]) by KNDFEX01.barco.com
	with Microsoft SMTPSVC(6.0.3790.4675);
	Fri, 12 Apr 2013 08:35:38 +0200
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Priority: normal
MIME-Version: 1.0
Date: Fri, 12 Apr 2013 08:35:38 +0200
Message-ID: <8D433CD511BE4646B47F8B31C900818E0CD26090@kndmex01.barco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] svn fetcher: do not save authentication
Thread-Index: Ac43R9MRI1UnTBtVQ1yyyIYDibLM1A==
From: "Vanveerdeghem, Simon" <Simon.Vanveerdeghem@barco.com>
To: <bitbake-devel@lists.openembedded.org>
X-OriginalArrivalTime: 12 Apr 2013 06:35:38.0243 (UTC)
	FILETIME=[F1FD2D30:01CE3747]
Cc: Simon.Vanveerdeghem@barco.com
Subject: [PATCH] svn fetcher: do not save authentication
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 12 Apr 2013 07:00:09 -0000
Content-Transfer-Encoding: 7bit
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CE3747.F1877FF8"

------_=_NextPart_001_01CE3747.F1877FF8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

=20

Signed-off-by: Simon Vanveerdeghem <simon.vanveerdeghem@barco.com>

---

lib/bb/fetch2/svn.py |    2 ++

1 file changed, 2 insertions(+)

=20

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py

index ea5902e..a64a461 100644

--- a/lib/bb/fetch2/svn.py

+++ b/lib/bb/fetch2/svn.py

@@ -81,6 +81,8 @@ class Svn(FetchMethod):

=20

         options =3D []

=20

+       options.append("--no-auth-cache")

+

         if ud.user:

             options.append("--username %s" % ud.user)

=20

--

1.7.10.4



DISCLAIMER:
Unless indicated otherwise, the information contained in this message is =
privileged and confidential, and is intended only for the use of the =
addressee(s) named above and others who have been specifically =
authorized to receive it. If you are not the intended recipient, you are =
hereby notified that any dissemination, distribution or copying of this =
message and/or attachments is strictly prohibited. The company accepts =
no liability for any damage caused by any virus transmitted by this =
email. Furthermore, the company does not warrant a proper and complete =
transmission of this information, nor does it accept liability for any =
delays. If you have received this message in error, please contact the =
sender and delete the message. Thank you.

------_=_NextPart_001_01CE3747.F1877FF8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Signed-off-by: Simon Vanveerdeghem =
&lt;simon.vanveerdeghem@barco.com&gt;<o:p></o:p></p><p =
class=3DMsoNormal>---<o:p></o:p></p><p class=3DMsoNormal> =
lib/bb/fetch2/svn.py |&nbsp;&nbsp;&nbsp; 2 ++<o:p></o:p></p><p =
class=3DMsoNormal> 1 file changed, 2 insertions(+)<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>diff --git =
a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py<o:p></o:p></p><p =
class=3DMsoNormal>index ea5902e..a64a461 100644<o:p></o:p></p><p =
class=3DMsoNormal>--- a/lib/bb/fetch2/svn.py<o:p></o:p></p><p =
class=3DMsoNormal>+++ b/lib/bb/fetch2/svn.py<o:p></o:p></p><p =
class=3DMsoNormal>@@ -81,6 +81,8 @@ class =
Svn(FetchMethod):<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;options =3D []<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
options.append(&quot;--no-auth-cache&quot;)<o:p></o:p></p><p =
class=3DMsoNormal>+<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
ud.user:<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; options.append(&quot;--username %s&quot; % =
ud.user)<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>--<o:p></o:p></p><p =
class=3DMsoNormal>1.7.10.4<o:p></o:p></p></div><p></p><p>DISCLAIMER:<br>U=
nless indicated otherwise, the information contained in this message is =
privileged and confidential, and is intended only for the use of the =
addressee(s) named above and others who have been specifically =
authorized to receive it. If you are not the intended recipient, you are =
hereby notified that any dissemination, distribution or copying of this =
message and/or attachments is strictly prohibited. The company accepts =
no liability for any damage caused by any virus transmitted by this =
email. Furthermore, the company does not warrant a proper and complete =
transmission of this information, nor does it accept liability for any =
delays. If you have received this message in error, please contact the =
sender and delete the message. Thank you.</body></html>

------_=_NextPart_001_01CE3747.F1877FF8--
