Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E72C61DD3
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 07:53:14 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2709.1788249187667922970
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Sep 2026 00:53:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=CgK8JOJz;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DAA9E4E4148E
	for <bitbake-devel@lists.openembedded.org>; Tue,  1 Sep 2026 07:53:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B00086053C
	for <bitbake-devel@lists.openembedded.org>; Tue,  1 Sep 2026 07:53:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C67A211C78C5E;
	Tue,  1 Sep 2026 09:53:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788249185; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=KXknYp1pzbSTNMs5WLN7NaZBNVg3f2PNfsHygqJ1zDc=;
	b=CgK8JOJzkkvz/bTAB6b5DT6FsRAtYsYnn3daFleAbK45XFdR4HCFitJYGZWlH+Xq5sgyoV
	AvSbIo/q3qq0hRTPh0MFSejIFRLXjg/1OoICmEnohlvZf5lpT6Yqw+Dxv1Ee6HS/MVaaxd
	yPemKJJVs6nL3FJS00iLazS0SS0RgI7lvYdusRqsWoCVQbtLo9miZELt3Vi5u/SABpVCnM
	v8sNV/HDBngCH5BNWfBhYnWK2qhVpjklxd/n74XzNmKLAhCKiEb5NlmA7WG5Ac0cD60PXh
	y+QVlJn4HYYhqVeDqVJaUi7TAE0/Ulbs0yGBT7s4nf9E2J6GjgtejB4U1vXMiQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 01 Sep 2026 09:52:51 +0200
Subject: [PATCH RFC] parse/ast: add support for additive built-in fragments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-appending-fragments-v1-1-2e359cf751ce@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBAAv1L2bCAm0IZeBR/gVTwkzTZdwTVkq
 xRK/95ojzMws4JgIRTomxUKfknozRXOpwaGyXNCRbEyGG1a7UynfM7IkTipsfj0Qp5FOW+1wxB
 Day3UMhccaflf73C7XuBxSPmEJw7z7wfbtgNp7ppdfAAAAA==
X-Change-ID: 20260827-appending-fragments-8a308ebdb633
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5359;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=xbEZ6zyPihwsLlvLUUGYmTDbY/QSnGrCp5BcaqG1yrM=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqloRfGNb6DeEEKCTPIZGiN4vqQeiuYoNURtuG/
 r1H5hFOFYOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCapaEXwAKCRDRgEFAKaOo
 NjEBD/4yEWLfbl6iWK/hdc3YeLxFrxWYgC4PM7CnhGvAqJmLgw0X2Hoi8y91Q+8+FbFWlElWpp8
 iLGSGLeYNJ3Rxu/bjQKn0FQAkpRrHK+ceePDF8HbZb8n4BO3DJCRzQBfku26uvdURBv04HpttcB
 IVr0CFQ8f9kXLzyfvwblNSg6hP/k11HVQp0BT8XkLuN+5BRpIVYoa+U33niYDMboYNtNUiIoAwU
 tYEKulHlJdqRZAn/spu2U/wjMwzxNML7GYVDc2uRNHO9XZkZwhYtNS/NyR16Hp4IVthAYptvW3E
 fetpNC0slkHF8UFQJ7kt8/m307MjRv93G088aQpnc9bwm0FG73kwG1Vm+BFyPArug1sj5s6qSer
 GZuas0SQvMl8uytHyeV/RE2jwpNeUk/reXINH3V2ZmLCLRsh689dY2FNsHMaXssNPasL+Ny+ooM
 ePXdNIWrKdkiPs4/jVsVDlpr90gn8/tLH83cPUc7EH4XuvH6vKkBV2tz2vpGGaNDPINhW2mLorx
 UFplRZjUM5l4xsImRX6JIIsJSK0+C7V9BARf155GaDlfPEWP+hbf9ZD06UbW5Chm57AI2VvMNg/
 tvbNTIDnyGP/mPSRzbPMytc7xM1bTgRkzfb9qigO0kZosiOSviBcL1O5r45L17uHSY6olwtkUMj
 8IPPhM/wq4cnUuw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 07:53:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20136

Add support for the following syntax specified in a fragment list
definition:

  fragmentname:VARIABLE:add

Setting this fragment appends to VARIABLE instead of setting its value.
This does not break pre-existing fragments which still set a variable's
value entirely.

For example, in OE-Core consider the following definition:

  OE_FRAGMENTS_BUILTIN = "class:INHERIT:add"

Then one could specify the following:

  OE_FRAGMENTS = "class/buildstats class/rm_work"

Which would result in appending " buildstats rm_work" to the INHERIT
variable.

This would also allow bitbake-setup configurations to come with a list
of pre-enabled classes, for example.

Note: The "add" suffix was chosen in the definition to avoid confusion
with the existing "append" usage in Bitbake.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Note: The bitbake-config-build OE-Core utility would require adaptations
as it currently removes any pre-existing built-in fragment with the
same suffix. I can also send the associated OE-Core patches.

Note 2: We could also have these fragments specified as:

  OE_FRAGMENTS = "class/add/buildstats class/add/retain"

To avoid confusing them with original built-in fragments. While I
agree it disambiguates them from original built-ins, I also think from a
user point of view, being able to set:

  OE_FRAGMENTS = "machine/qemuarm distro/poky class/buildstats class/retain"

feels a bit more natural. Discussion is open :)
---
 lib/bb/parse/ast.py | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index a372b3534e4..a828c49c937 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -367,12 +367,13 @@ class AddFragmentsNode(AstNode):
         def check_and_set_builtin_fragment(fragment, data, builtin_fragments):
             prefix, value = fragment.split('/', 1)
             if prefix in builtin_fragments.keys():
-                if data.getVar(builtin_fragments[prefix], noweakdefault=True) != None:
+                fragment_var, fragment_type = builtin_fragments[prefix][0], builtin_fragments[prefix][1]
+                if fragment_type == "set" and data.getVar(fragment_var, noweakdefault=True) is not None:
                     bb.fatal(
                         ("A builtin fragment '%s' is used while %s has already got an assignment.\n"
                          "Please either disable the fragment or remove the value assignment.\n"
                          "To disable the fragment, use 'bitbake-config-build disable-fragment %s'."
-                         ) % (fragment, builtin_fragments[prefix], fragment))
+                         ) % (fragment, fragment_var, fragment))
                 fragment_history = data.varhistory.variable(self.fragments_variable)
                 loginfo={}
                 for fh in fragment_history[::-1]:
@@ -381,15 +382,27 @@ class AddFragmentsNode(AstNode):
                         loginfo["line"]   = fh["line"]
                         loginfo["detail"] = f"{value} ({self.fragments_variable} contains \"{fragment}\")"
                         break
-                # parsing=True since we want to emulate X=Y and allow X:override=Z to continue to exist
-                data.setVar(builtin_fragments[prefix], value, parsing=True, **loginfo)
+                if fragment_type == "set":
+                    # parsing=True since we want to emulate X=Y and allow X:override=Z to continue to exist
+                    data.setVar(fragment_var, value, parsing=True, **loginfo)
+                elif fragment_type == "add":
+                    data.appendVar(fragment_var, f" {value.strip()}", **loginfo)
+                else:
+                    bb.fatal(f"Unknown fragment type '{fragment_type}' "
+                             f"(from '{prefix}:{fragment_var}:{fragment_type}' in {self.builtin_fragments_variable})")
                 return True
             return False
 
         fragments = data.getVar(self.fragments_variable)
         layers = data.getVar('BBLAYERS')
         flagged_variables = data.getVar(self.flagged_variables_list_variable).split()
-        builtin_fragments = {f[0]:f[1] for f in [f.split(':') for f in data.getVar(self.builtin_fragments_variable).split()] }
+        builtin_fragments = {}
+        for fragment in data.getVar(self.builtin_fragments_variable).split():
+            fragment = fragment.split(':')
+            builtin_fragments[fragment[0]] = (
+                fragment[1],
+                "set" if len(fragment) < 3 else fragment[2],
+            )
 
         if not fragments:
             return
@@ -402,7 +415,7 @@ class AddFragmentsNode(AstNode):
                     fragments.split(),
                 )
             )
-            if len(builtin_fragments_list) > 1:
+            if len(builtin_fragments_list) > 1 and not builtin_fragments[builtin_fragment_key][1] == "add":
                 bb.warn(
                     ("Multiple builtin fragments are enabled for %s via variable %s: %s. "
                      "This likely points to a mis-configuration in the metadata, as only "

---
base-commit: 18cca50ba3da5ce27bc674478957bb08e7536b9a
change-id: 20260827-appending-fragments-8a308ebdb633


