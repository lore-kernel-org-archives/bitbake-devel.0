Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by mail.openembedded.org (Postfix) with ESMTP id A408C65E2F
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 13:17:45 +0000 (UTC)
Received: by mail-we0-f179.google.com with SMTP id x48so2374887wes.24
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Apr 2014 06:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=BJysBbNNQo8WrOd8U58cniUisqDwaqR+Br9n+34284Y=;
	b=RPHagmAeco03xMMtaC35gWjZOfiATjqiEdKjHijvv1P4LSfNqdCgaKj4d1Y3Z9PsFd
	WBxEAghzSpfeND7DT+oQ+MzLpjFlvpg4pPF1X7fW8xsa9+06kraeujcnGvK5v5THJQWf
	bqos4OuI9Eb3UoDrZmbgOBj2XLff7byHrSe4t1tKC8LrMAJRqvk32zljc/c5DHSpX4sr
	rtOihBTY9eTzcdh99UJqCgu9pKd5H+0gSTp9Bg7aXhRoNhpvabAgswVfM6fU9ssdHGPp
	5Ie8IW3B23LyTk4wgpeemEd73Zvw2vfvID+yLh7xAQitOz8iRlheUhKD2bZGBLObUOvs
	2Qiw==
X-Gm-Message-State: ALoCoQm0novR6PkWqKwjSMDeOKdO4ROtGyIVad6qRaGk78vC242SdDiNr3QXjwKCRsgW0kKoo1ew
X-Received: by 10.194.89.40 with SMTP id bl8mr79116wjb.90.1397049465449;
	Wed, 09 Apr 2014 06:17:45 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ff9sm10065223wib.11.2014.04.09.06.17.42 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Apr 2014 06:17:44 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 74D34560236; Wed,  9 Apr 2014 14:17:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Apr 2014 14:17:34 +0100
Message-Id: <e0d3dfe4bf9ab82a045ca5806a0716c6c4538252.1397049329.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
References: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1397049329.git.alexandru.damian@intel.com>
References: <cover.1397049329.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 3/9] toaster: show unique set-in files in configvar
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
X-List-Received-Date: Wed, 09 Apr 2014 13:17:47 -0000

From: David Reyna <David.Reyna@windriver.com>

When listing the set-in files in the configure varaible table, only show
each file once in that summary view.

[YOCTO #6048]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templatetags/projecttags.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index ee08ab7..aa1ebf8 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -164,21 +164,25 @@ def filter_setin_files(file_list,matchstr):
     if search == '':
         for i in range(len(file_list)):   
             if file_list[i].file_name.find(filter) >= 0:
-                htmlstr += file_list[i].file_name + "<p>"
+                if htmlstr.find(file_list[i].file_name + "<p>") < 0:
+                    htmlstr += file_list[i].file_name + "<p>"
         return htmlstr
        
     # match only search string, plus always last file
     if filter == "":
         for i in range(len(file_list)-1):   
             if file_list[i].file_name.find(search) >= 0:
-                htmlstr += file_list[i].file_name + "<p>"
-        htmlstr += file_list[len(file_list)-1].file_name
+                if htmlstr.find(file_list[i].file_name + "<p>") < 0:
+                    htmlstr += file_list[i].file_name + "<p>"
+        if htmlstr.find(file_list[len(file_list)-1].file_name) < 0:
+            htmlstr += file_list[len(file_list)-1].file_name
         return htmlstr
        
     # match filter or search string
     for i in range(len(file_list)):   
         if (file_list[i].file_name.find(filter) >= 0) or (file_list[i].file_name.find(search) >= 0):
-            htmlstr += file_list[i].file_name + "<p>"
+            if htmlstr.find(file_list[i].file_name + "<p>") < 0:
+                htmlstr += file_list[i].file_name + "<p>"
     return htmlstr
 
 
-- 
1.9.1


