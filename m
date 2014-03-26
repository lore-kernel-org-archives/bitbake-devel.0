Return-Path: <Reinhard.Thies@web.de>
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by mail.openembedded.org (Postfix) with ESMTP id 1CFA96F9EF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 12:58:43 +0000 (UTC)
Received: from silent.localnet ([145.253.169.211]) by smtp.web.de (mrweb102)
	with ESMTPSA (Nemesis) id 0LlF9O-1X2Osp47Ik-00b0rC;
	Wed, 26 Mar 2014 13:58:42 +0100
To: bitbake-devel@lists.openembedded.org
From: Reinhard Thies <Reinhard.Thies@web.de>
Date: Wed, 26 Mar 2014 13:58:41 +0100
X-KMail-Markup: true
MIME-Version: 1.0
Message-Id: <201403261358.41447.Reinhard.Thies@web.de>
X-Provags-ID: V03:K0:rq8RUmyF6DTQABH25SGBGVS2oaQB213npII/JZ1GrpU+e/+mfBO
	1qPB+8QvriDk8FkO/VsTqXTCgu0vEwyPC5Ae4R/CCN5ec3gfffH/DVR94A6Mh5FLFhsj1td
	Al/gRvpLyHUjPqRI1r7uBwl/mnMVbQ4NI0tUpnebpRXWFn71WEzttLYBrUarHHXSoABQehd
	KoohLK8tpkf1jtXJpLheA==
Subject: gitsm
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
X-List-Received-Date: Wed, 26 Mar 2014 12:58:44 -0000
Content-Type: multipart/alternative; boundary="Boundary-01=_B8sMTiFPbuW/vyI"
Content-Transfer-Encoding: 7bit

--Boundary-01=_B8sMTiFPbuW/vyI
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

I am just started to work with gitsm. Maybe I am doing something wrong because 
it wont work until I remove a line in the gitsm.py file.

I have so idea what the line should be for and would appreciate any help.

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index 572b637..06f7fb7 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -68,11 +68,11 @@ class GitSM(Git):
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
-        
+
         os.chdir(ud.destdir)
         submodules = self.uses_submodules(ud, d)
         if submodules:
-            runfetchcmd("cp -r " + ud.clonedir + "/modules " + ud.destdir + 
"/.git/", d)
+#            runfetchcmd("cp -r " + ud.clonedir + "/modules " + ud.destdir + 
"/.git/", d)
             runfetchcmd("git submodule init", d)
             runfetchcmd("git submodule update", d)

--
thx
Reinhard




--Boundary-01=_B8sMTiFPbuW/vyI
Content-Type: text/html;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'Arial'; font-size:14pt; font-weight:600; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Hi,</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I am just started to work with gitsm. Maybe I am doing something wrong because it wont work until I remove a line in the gitsm.py file.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I have so idea what the line should be for and would appreciate any help.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">index 572b637..06f7fb7 100644</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">--- a/bitbake/lib/bb/fetch2/gitsm.py</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">+++ b/bitbake/lib/bb/fetch2/gitsm.py</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">@@ -68,11 +68,11 @@ class GitSM(Git):</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"> </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">     def unpack(self, ud, destdir, d):</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">         Git.unpack(self, ud, destdir, d)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">-        </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">+</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">         os.chdir(ud.destdir)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">         submodules = self.uses_submodules(ud, d)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">         if submodules:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">-            runfetchcmd(&quot;cp -r &quot; + ud.clonedir + &quot;/modules &quot; + ud.destdir + &quot;/.git/&quot;, d)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">+#            runfetchcmd(&quot;cp -r &quot; + ud.clonedir + &quot;/modules &quot; + ud.destdir + &quot;/.git/&quot;, d)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">             runfetchcmd(&quot;git submodule init&quot;, d)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">             runfetchcmd(&quot;git submodule update&quot;, d)</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">--</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">thx</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Reinhard</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p></body></html>

--Boundary-01=_B8sMTiFPbuW/vyI--
