Return-Path: <prvs=8100dda83d=cherzig@gauselmann.de>
X-Greylist: delayed 965 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 16 Jul 2019 12:56:05 UTC
Received: from mail2.gauselmann.com (mail2.gauselmann.com [193.102.155.89])
	by mail.openembedded.org (Postfix) with ESMTP id 385B67E608
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Jul 2019 12:56:04 +0000 (UTC)
Received: from pps.filterd (mail2.gauselmann.com [127.0.0.1])
	by mail2.gauselmann.com (8.16.0.27/8.16.0.27) with SMTP id
	x6GCbkdN010703 for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Jul 2019 14:40:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merkurinternational.es;
	h=to :
	mime-version : subject : message-id : from : date : content-type;
	s=20190701; bh=dWcsx3+oC6QawxCNCfwK6swwYw7SCQOYsD3Wk6/bYOg=;
	b=c+LL21gQEAbndy8FDxwb7iSCtBW/IBqIuQ2Oo7FWZWTubJMUXEZWlbaBjbvpSR2SXEcH
	rhA78KBuv5EpCVmXwcl3gMWf9md+0731VLQbkouOQOMGr6rx0eXcMXjQKXHM2ExRssMz
	nQ7RPSqBkVizeq7nvnqExY+1f3AzVAA+2bmqumfbA6b+MFSkhgPyAJ4tb6h85jbolHMw
	BXdIaeWa2dQ1Yr7mKpNkR4fL4M6Nl8HRTzgfzk4YKNlytjtTRcFTgZlWR8OM1d86Zx0G
	lDKymET/d0QsDJ/csYZbg3Wjii+cnVUCkgD4GTZmV36m3Lz1cFB3Vq5/ADyHT9ZqpHLV
	Jw== 
Received: from bswinp16.gg.gauselmann.com ([10.99.84.148])
	by mail2.gauselmann.com with ESMTP id 2tq5xxnf1j-1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Jul 2019 14:40:00 +0200
Received: from wm01.gauselmann.com ([10.99.82.28])
	by BSWINP16.gg.gauselmann.com with ESMTP id 2019071614395898-13164 ;
	Tue, 16 Jul 2019 14:39:58 +0200 
To: bitbake-devel@lists.openembedded.org
MIME-Version: 1.0
X-KeepSent: C877F210:CFACEB8C-C1258439:0045176E;
	type=4; flags=0; name=$KeepSent
Message-ID: <OFC877F210.CFACEB8C-ONC1258439.0045176E-C1258439.00459417@gauselmann.com>
From: CHerzig@Gauselmann.de
Date: Tue, 16 Jul 2019 14:39:58 +0200
X-MIMETrack: Serialize by Router on LNS3/BEIT GmbH at 16.07.2019 14:39:58,
	Serialize complete at 16.07.2019 14:39:58,
	Itemize by SMTP Server on LNS13/BEIT GmbH at 16.07.2019 14:39:58,
	Serialize by Router on LNS13/BEIT GmbH at 16.07.2019 14:40:00,
	Serialize complete at 16.07.2019 14:40:00
X-TNEFEvaluated: 1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-07-16_03:, , signatures=0
Subject: [PATCH] fetch2/ccrc: import required error classes
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
X-List-Received-Date: Tue, 16 Jul 2019 12:56:05 -0000
Content-Type: multipart/alternative;
	boundary="=_alternative 00459417C1258439_="

--=_alternative 00459417C1258439_=
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Christian Herzig <cherzig@gauselmann.de>
---
 bitbake/lib/bb/fetch2/clearcase.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/clearcase.py 
b/bitbake/lib/bb/fetch2/clearcase.py
index 09c9d0c33c..a276144426 100644
--- a/bitbake/lib/bb/fetch2/clearcase.py
+++ b/bitbake/lib/bb/fetch2/clearcase.py
@@ -56,6 +56,8 @@ import shutil
 import bb
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
+from   bb.fetch2 import MissingParameterError
+from   bb.fetch2 import ParameterError
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 
@@ -81,7 +83,7 @@ class ClearCase(FetchMethod):
         if 'protocol' in ud.parm:
             ud.proto = ud.parm['protocol']
         if not ud.proto in ('http', 'https'):
-            raise fetch2.ParameterError("Invalid protocol type", ud.url)
+            raise ParameterError("Invalid protocol type", ud.url)
 
         ud.vob = ''
         if 'vob' in ud.parm:
-- 
2.17.1



--=_alternative 00459417C1258439_=
Content-Type: text/html; charset="US-ASCII"

<tt><span style=" font-size:10pt">Signed-off-by: Christian Herzig &lt;cherzig@gauselmann.de&gt;<br>
---<br>
 bitbake/lib/bb/fetch2/clearcase.py | 4 +++-<br>
 1 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/clearcase.py b/bitbake/lib/bb/fetch2/clearcase.py<br>
index 09c9d0c33c..a276144426 100644<br>
--- a/bitbake/lib/bb/fetch2/clearcase.py<br>
+++ b/bitbake/lib/bb/fetch2/clearcase.py<br>
@@ -56,6 +56,8 @@ import shutil<br>
 import bb<br>
 from &nbsp; bb.fetch2 import FetchMethod<br>
 from &nbsp; bb.fetch2 import FetchError<br>
+from &nbsp; bb.fetch2 import MissingParameterError<br>
+from &nbsp; bb.fetch2 import ParameterError<br>
 from &nbsp; bb.fetch2 import runfetchcmd<br>
 from &nbsp; bb.fetch2 import logger<br>
 <br>
@@ -81,7 +83,7 @@ class ClearCase(FetchMethod):<br>
 &nbsp; &nbsp; &nbsp; &nbsp; if 'protocol' in ud.parm:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ud.proto = ud.parm['protocol']<br>
 &nbsp; &nbsp; &nbsp; &nbsp; if not ud.proto in ('http', 'https'):<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;raise fetch2.ParameterError(&quot;Invalid
protocol type&quot;, ud.url)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;raise ParameterError(&quot;Invalid
protocol type&quot;, ud.url)<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; ud.vob = ''<br>
 &nbsp; &nbsp; &nbsp; &nbsp; if 'vob' in ud.parm:<br>
-- <br>
2.17.1<br>
<br>
</span></tt>
<br>

--=_alternative 00459417C1258439_=--
