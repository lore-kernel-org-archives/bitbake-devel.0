Return-Path: <prvs=3260bcf0e2=cherzig@gauselmann.de>
X-Greylist: delayed 1465 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 23 Dec 2019 16:24:09 UTC
Received: from mail2.gauselmann.com (mail2.gauselmann.com [193.102.155.89])
	by mail.openembedded.org (Postfix) with ESMTP id D11196C23A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 16:24:09 +0000 (UTC)
Received: from pps.filterd (mail2.gauselmann.com [127.0.0.1])
	by mail2.gauselmann.com (8.16.0.27/8.16.0.27) with SMTP id
	xBNFwNCY005251; Mon, 23 Dec 2019 16:59:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gauselmann.de;
	h=to : cc :
	mime-version : subject : message-id : from : date : content-type;
	s=20190718; bh=86r6n58otdcR5AL7TqEgss5F6jNU60DO2nXcqKKdX0Q=;
	b=fplzj204T2Mk+y/KYnsTh3Lt/XbWbovhB9V6nmZ723Wkyil9+3mL7nCa7vXvvCyz9M45
	ATJn3SZbl8RC203vW8HoQkl//kDEj67T1ySdnl+KZZLkkkuDjt+7iJcwt+tlmVGTs+XZ
	VWo8IcKjCvhEThDfPUkbrlm9cjtEtWaRSaFMrSCAfFQ/XsR5xMatgO652N+gQdWz9B7Q
	heggoVeYiT5ovxnQd5kFcNRCsfAbW7LAeIhGaNRkq07JXx6FLmN260w0ZShyCS19n1Jj
	SGeS7rCc0YgtpjXvKSflI1IdHilkONjzOOazL49GBbV2jhZAJgf/KUEM+rAUi7yGkDjK
	UQ== 
Received: from bswinp16.gg.gauselmann.com ([10.99.84.148])
	by mail2.gauselmann.com with ESMTP id 2x1awyja5s-1;
	Mon, 23 Dec 2019 16:59:41 +0100
Received: from wm01.gauselmann.com ([10.99.82.28])
	by BSWINP16.gg.gauselmann.com with ESMTP id 2019122316594161-5924 ;
	Mon, 23 Dec 2019 16:59:41 +0100 
To: bitbake-devel@lists.openembedded.org, poky@lists.yoctoproject.org
MIME-Version: 1.0
X-KeepSent: D5254A7C:60A3DB90-C12584D9:00487C7B;
	type=4; flags=0; name=$KeepSent
Message-ID: <OFD5254A7C.60A3DB90-ONC12584D9.00487C7B-C12584D9.0057DCCA@gauselmann.com>
From: CHerzig@Gauselmann.de
Date: Mon, 23 Dec 2019 16:59:41 +0100
X-MIMETrack: Serialize by Router on LNS3/BEIT GmbH at 23.12.2019 16:59:41,
	Serialize complete at 23.12.2019 16:59:41,
	Itemize by SMTP Server on LNS13/BEIT GmbH at 23.12.2019 16:59:41,
	Serialize by Router on LNS13/BEIT GmbH at 23.12.2019 16:59:41
X-TNEFEvaluated: 1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-12-23_07:, , signatures=0
Subject: [PATCH] bitbake: fetch2/clearcase: Fix tar command
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
X-List-Received-Date: Mon, 23 Dec 2019 16:24:10 -0000
Content-Type: multipart/alternative;
	boundary="=_alternative 0057DCC8C12584D9_="

--=_alternative 0057DCC8C12584D9_=
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Christian Herzig <cherzig@gauselmann.de>
---
 bitbake/lib/bb/fetch2/clearcase.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/clearcase.py 
b/bitbake/lib/bb/fetch2/clearcase.py
index e2934ef9fc..ad2f3edc74 100644
--- a/bitbake/lib/bb/fetch2/clearcase.py
+++ b/bitbake/lib/bb/fetch2/clearcase.py
@@ -238,7 +238,7 @@ class ClearCase(FetchMethod):
 
         # Clean clearcase meta-data before tar
 
-        runfetchcmd('tar -czf "%s" .' % (ud.localpath), d, cleanup = 
[ud.localpath])
+        runfetchcmd('tar -czf "%s" .' % (ud.localpath), d, cleanup = 
[ud.localpath], workdir = ud.viewdir)
 
         # Clean up so we can create a new view next time
         self.clean(ud, d);
-- 
2.17.1



--=_alternative 0057DCC8C12584D9_=
Content-Type: text/html; charset="US-ASCII"

<tt><span style=" font-size:10pt">Signed-off-by: Christian Herzig &lt;cherzig@gauselmann.de&gt;<br>
---<br>
 bitbake/lib/bb/fetch2/clearcase.py | 2 +-<br>
 1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/clearcase.py b/bitbake/lib/bb/fetch2/clearcase.py<br>
index e2934ef9fc..ad2f3edc74 100644<br>
--- a/bitbake/lib/bb/fetch2/clearcase.py<br>
+++ b/bitbake/lib/bb/fetch2/clearcase.py<br>
@@ -238,7 +238,7 @@ class ClearCase(FetchMethod):<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; # Clean clearcase meta-data before tar<br>
 <br>
- &nbsp; &nbsp; &nbsp; &nbsp;runfetchcmd('tar -czf &quot;%s&quot; .' %
(ud.localpath), d, cleanup = [ud.localpath])<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;runfetchcmd('tar -czf &quot;%s&quot; .' %
(ud.localpath), d, cleanup = [ud.localpath], workdir = ud.viewdir)<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; # Clean up so we can create a new view next
time<br>
 &nbsp; &nbsp; &nbsp; &nbsp; self.clean(ud, d);<br>
-- <br>
2.17.1<br>
<br>
</span></tt>
<br>

--=_alternative 0057DCC8C12584D9_=--
