Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E63C4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 19:44:21 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.37928.1702583059696114010
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Dec 2023 11:44:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=swTJ7TP9;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 64EF89C40EA;
	Thu, 14 Dec 2023 14:44:18 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id IrfwJSi9kdtX; Thu, 14 Dec 2023 14:44:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id ACFA49C2C84;
	Thu, 14 Dec 2023 14:44:17 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com ACFA49C2C84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702583057; bh=yQ2jHfkPsfuBKM7dsRvXxxOk9KOtAwXs78BMYDhIeX8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=swTJ7TP99adtO3wkXPwFGmoyTbYP8Q32jaxrpfELJ23eee0r3m00v3x2psSFvbCEf
	 q2T/DTpMB/RcBUXibj43y7IEt6XcsFq5+6nOv/f8+H68djjoLOh6psrqRLbWnXrO0+
	 vZWJTliuyZXBlgzL2kE7nONz4QWR0TvKze6S8gAuVZWzE932NNN9+TliDfzKCwq0+w
	 p8lJbOmWEek06bw4ancTO0dJ9iHZ+t37aVLar0D+IxHJDl6htgldb6MqkXJz73ZJsx
	 oxrTS8EUWF+vSSNRTrVpmlTR8BYCKvruu/iPo2kI7NZrbXoNDzZfPwpo/yBRKd5dpS
	 bPxeEY4rJTm8Q==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5R0FjyGCAb0J; Thu, 14 Dec 2023 14:44:17 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 8632C9C0C12;
	Thu, 14 Dec 2023 14:44:17 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [PATCH] toaster: Added validation to stop import if there is a build in progress
Date: Thu, 14 Dec 2023 14:44:09 -0500
Message-Id: <20231214194409.16525-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 19:44:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15669

Added validation to prevent simultaneous imports from running because the=
 database fails at runtime.
The option to create a queue was taken into consideration. However, it wi=
ll require the use of Celery https://pypi.org/project/celery/ or Backgrou=
nd Task https://pypi.org/project/django-background-tasks/ which require t=
he use of external services and multiple dependencies.
If required we could explore the alternative in the future.

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 lib/toaster/toastergui/templates/command_line_builds.html | 6 +++++-
 lib/toaster/toastergui/views.py                           | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/command_line_builds.html b/=
lib/toaster/toastergui/templates/command_line_builds.html
index fcbe80d8..05db6727 100644
--- a/lib/toaster/toastergui/templates/command_line_builds.html
+++ b/lib/toaster/toastergui/templates/command_line_builds.html
@@ -152,7 +152,11 @@ function _ajax_update(file, all, dir){
         type: "POST",
         data: {file: file, all: all, dir: dir},
         success:function(data){
-            window.location =3D '/toastergui/builds/'
+            if (data['response']=3D=3D'building'){
+                location.reload()
+            } else {
+                window.location =3D '/toastergui/builds/'
+            }
         },
         complete:function(data){
         },
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/vie=
ws.py
index 3b5b9f5b..40aed265 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2018,6 +2018,14 @@ class CommandLineBuilds(TemplateView):
         logs_dir =3D request.POST.get('dir')
         all_files =3D  request.POST.get('all')
=20
+        # check if a build is already in progress
+        if Build.objects.filter(outcome=3DBuild.IN_PROGRESS):
+            messages.add_message(
+                self.request,
+                messages.ERROR,
+                "A build is already in progress. Please wait for it to c=
omplete before starting a new build."
+            )
+            return JsonResponse({'response': 'building'})
         imported_files =3D EventLogsImports.objects.all()
         try:
             if all_files =3D=3D 'true':
--=20
2.34.1


