Return-Path: <pandey_himanshu80@rediffmail.com>
Received: from f4mail-83-111.rediffmail.com (unknown [203.199.83.114])
	by mail.openembedded.org (Postfix) with ESMTP id 22BB773866
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Mar 2015 12:05:02 +0000 (UTC)
Received: from rediffmail.com (unknown [10.50.250.70])
	by f4mail-83-111.rediffmail.com (Postfix) with SMTP id DBD852471CDE
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Mar 2015 17:31:51 +0530 (IST)
Received: (qmail 26989 invoked by uid 510); 3 Mar 2015 12:04:51 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=redf; d=rediffmail.com;
	b=Twxqh2YZAsRsHB9ubzwe8uPhGkDpHaQH4uChGRMdttACfm/d4HLFcRt5QPXBfIdHJaO0E9CoYd2vvNilzbbL/107OeQvvyC9/7kbhIbSBLJ7JABhA905Wm0PeEldGeHLsIjNmbf91W5PjafWJzvt+0xj9bxgdDpAO12zQL+xVJc=
	; 
x-m-msg: asd54ad564ad7aa6sd5as6d5; a6da7d6asas6dasd77; 5dad65ad5sd;
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: : 0
X-CTCH-RefID: str=0001.0A160209.54F5A363.0058, ss=1, re=0.000, recu=0.000,
	reip=0.000, cl=1, cld=1, fgs=0
X-REDF-OSEN: pandey_himanshu80@rediffmail.com
Date: 3 Mar 2015 12:04:50 -0000
MIME-Version: 1.0
To: "Alex DAMIAN " <alexandru.damian@intel.com>
Received: from unknown 103.25.205.2 by rediffmail.com via HTTP;
	03 Mar 2015 12:04:50 -0000
X-Senderscore: D=0&S=0
Message-ID: <1424798506.S.8700.28221.F.H.TkFsZXggREFNSUFOAFtiaXRiYWtlLWRldmVsXSBbUEFUQ0ggMDEvMTJdIHRvYXN0ZXJndWk6IGZpeCBzcGE_.RU.rfs313,
	rfs313, 131,
	946.f4-234-191.1425384290.26032@webmail.rediffmail.com>
Sender: pandey_himanshu80@rediffmail.com
From: "Himanshu  Pandey" <pandey_himanshu80@rediffmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 01/12] toastergui: fix spacing and input field sizes
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
X-List-Received-Date: Tue, 03 Mar 2015 12:05:03 -0000
Content-Type: multipart/alternative;
	boundary="=_c394f9a7ed9de61e58e6c74ddd1e5bb2"

--=_c394f9a7ed9de61e58e6c74ddd1e5bb2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"

Hi,
When I compile my image using the command bitbake:
bitbake core-image-lb
it shows:
meta-lb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = "&lt;unknown&gt;:&lt;unknown&gt;"

Also I have included the package "bash" in conf/local.conf for this image. But the image is neither compiling the bash package nor it is installing it.
Where shall I include the bash package in my image.
Regards,Himanshu&nbsp;

From: Alex DAMIAN &lt;alexandru.damian@intel.com&gt;
Sent: Tue, 24 Feb 2015 22:51:46 
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] [PATCH 01/12] toastergui: fix spacing and input field sizes
From: Belen Barros Pena &lt;belen.barros.pena@intel.com&gt;



The revision label was missing the projec-form class (which

controls the spacing in the form), and the revision text

field was a bit too long, so changed it from span4 to

span3.

---

 lib/toaster/toastergui/templates/importlayer.html | 4 ++--

 1 file changed, 2 insertions(+), 2 deletions(-)



diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html

index 1196e0c..19d2fc4 100644

--- a/lib/toaster/toastergui/templates/importlayer.html

+++ b/lib/toaster/toastergui/templates/importlayer.html

@@ -75,11 +75,11 @@

 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;input type="text" &nbsp;id="layer-subdir"&gt;

 

 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;div class="control-group" id="layer-revision-ctrl"&gt;

- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;label class="control-label" for="layer-git-ref"&gt;Revision

+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;label class="control-label project-form" for="layer-git-ref"&gt;Revision

 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;span class="icon-question-sign get-help" title="You can provide a Git branch, a tag or a commit SHA as the revision"&gt;&lt;/span&gt;

 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;/label&gt;

 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;div class="controls"&gt;

- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;input type="text" class="span4" id="layer-git-ref" required&gt;

+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;input type="text" class="span3" id="layer-git-ref" required&gt;

 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;span class="help-inline" style="diaply:none;" id="invalid-layer-revision-hint"&gt;&lt;/span&gt;

 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;/div&gt;

 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;/div&gt;

-- 

1.9.1



-- 

_______________________________________________

bitbake-devel mailing list

bitbake-devel@lists.openembedded.org

http://lists.openembedded.org/mailman/listinfo/bitbake-devel


--=_c394f9a7ed9de61e58e6c74ddd1e5bb2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

Hi,<div><br></div><div>When I compile my image using the command bitbake:</=
div><div><br></div><div>bitbake core-image-lb</div><div><br></div><div>it s=
hows:</div><div><br></div><div>meta-lb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
=3D "&lt;unknown&gt;:&lt;unknown&gt;"<br><br>Also I have included the packa=
ge "bash" in conf/local.conf for this image. But the image is neither compi=
ling the bash package nor it is installing it.</div><div><br></div><div>Whe=
re shall I include the bash package in my image.</div><div><br></div><div>R=
egards,</div><div>Himanshu&nbsp;<br><br>From: Alex DAMIAN &lt;alexandru.dam=
ian@intel.com&gt;<br>Sent: Tue, 24 Feb 2015 22:51:46 <br>To: bitbake-devel@=
lists.openembedded.org<br>Subject: [bitbake-devel] [PATCH 01/12] toastergui=
: fix spacing and input field sizes<br>From: Belen Barros Pena &lt;belen.ba=
rros.pena@intel.com&gt;<br>
<br>
The revision label was missing the projec-form class (which<br>
controls the spacing in the form), and the revision text<br>
field was a bit too long, so changed it from span4 to<br>
span3.<br>
---<br>
 lib/toaster/toastergui/templates/importlayer.html | 4 ++--<br>
 1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaste=
r/toastergui/templates/importlayer.html<br>
index 1196e0c..19d2fc4 100644<br>
--- a/lib/toaster/toastergui/templates/importlayer.html<br>
+++ b/lib/toaster/toastergui/templates/importlayer.html<br>
@@ -75,11 +75,11 @@<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &lt;input type=3D"text" &nbsp;id=3D"layer-subdir"&gt;<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &lt;div class=3D"control-group" id=3D"layer-revision-ctrl"=
&gt;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;&lt;label class=3D"control-label" for=3D"layer-git-=
ref"&gt;Revision<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;&lt;label class=3D"control-label project-form" for=
=3D"layer-git-ref"&gt;Revision<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &lt;span class=3D"icon-question-sign get-hel=
p" title=3D"You can provide a Git branch, a tag or a commit SHA as the revi=
sion"&gt;&lt;/span&gt;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &lt;/label&gt;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &lt;div class=3D"controls"&gt;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;input type=3D"text" class=3D"span4" id=
=3D"layer-git-ref" required&gt;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;input type=3D"text" class=3D"span3" id=
=3D"layer-git-ref" required&gt;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;span class=3D"help-inline" style=
=3D"diaply:none;" id=3D"invalid-layer-revision-hint"&gt;&lt;/span&gt;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &lt;/div&gt;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &lt;/div&gt;<br>
-- <br>
1.9.1<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
bitbake-devel@lists.openembedded.org<br>
http://lists.openembedded.org/mailman/listinfo/bitbake-devel<br>
</div><br><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/ww=
w.rediffmail.com/signatureline.htm@Middle?" target=3D"_blank"><IMG SRC=3D"h=
ttp://sigads.rediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/si=
gnatureline.htm@Middle"></A><table cellpadding=3D"0" cellspacing=3D"0"><tbo=
dy><tr><td><div style=3D"font-family: Arial, Helvetica, sans-serif; font-si=
ze:14px">Get your own <span style=3D"padding-bottom: 0px; background-color:=
 #cc0000; padding-left: 3px; padding-RIGHT: 3px; font-family: Arial, Helvet=
ica, sans-serif; color: #ffffff; font-size: 12px; padding-top: 0px"><b>FREE=
</b></span> website,  <span style=3D"padding-bottom: 0px; background-color:=
 #c00; padding-left: 3px; padding-RIGHT: 3px; font-family: Arial, Helvetica=
, sans-serif; color: #ffffff; font-size: 12px; padding-top: 0px"><b>FREE</b=
></span> domain &amp; <span style=3D"padding-bottom: 0px; background-color:=
 #c00; padding-left: 3px; padding-RIGHT: 3px; font-family: Arial, Helvetica=
, sans-serif; color: #ffffff; font-size: 12px; padding-top: 0px"><b>FREE</b=
></span> mobile app with Company email. &nbsp;</div></td><td><a href=3D"htt=
p://track.rediff.com/click?url=3D___http://businessemail.rediff.com?sc_cid=
=3Dsign-1-10-13___&cmp=3Dhost&lnk=3Dsign-1-10-13&nsrv1=3Dhost" style=3D"fon=
t-family: Arial, Helvetica, sans-serif; color: #fff; font-size: 14px; color=
:#0000cc" target=3D"_blank"><b>Know More ></b></a><!-- <in-put type=3D"butt=
on" cl-ass=3D"button" on-click=3D"parent.location=3D&#39;http://track.redif=
f.com/click?url=3D___http://businessemail.rediff.com/company-email-hosting-=
services?sc_cid=3Dsignature-23-9-13___&amp;cmp=3Dsignature-23-9-13&amp;lnk=
=3Dmypagelogout&amp;nsrv1=3Dhost&#39;" value=3D"Know more &gt;"> </input> -=
-></td></tr></tbody></table>

--=_c394f9a7ed9de61e58e6c74ddd1e5bb2--
