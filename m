Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 4491B6F77C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:34 +0000 (UTC)
Received: by mail-wi0-f174.google.com with SMTP id d1so2701954wiv.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=yM8RX++SW8ylrPUZZtXAbjM16xmKjlALn3AespOBWnw=;
	b=IbG88ShicTX3AtXBt6TcSH6SI8RWXX2T33jsiOZicVmKOMj5WweFZM0KjyxXQ9hDp7
	22ehMQVo+5piUP7Xnk7BRQFtwXLJmavw0DGQE6BAX/hvjTKuI3lc+Hn5qAYCLed2JvIh
	71Y8BZqs0qUsgCyU1C+Sy4HJwj6d2aODVDxvZdauVqy6S50lfE8u0DTUJR8W27L6Oy1c
	/sSQ2lqjp8V6VJTe8ntkL64uVilk6Aucf0+ijfzR3Qal3mX5AObjNTtYhetlEMQsebZr
	Iy7fq2TX6vkHjLl1bw1AZpjwpNK3DJiYyxfIxmV8mWjWb766w4JmP5h3XUjH9JAFyqov
	jPeA==
X-Gm-Message-State: ALoCoQmwDVL7ezQ5WEjAOxGo5C2iIKS70BM737N6G8vZq2XAvVzUA3JAJ7tdz3cC+P3jQWGzIcA5
X-Received: by 10.180.100.70 with SMTP id ew6mr16536526wib.57.1395686255614;
	Mon, 24 Mar 2014 11:37:35 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id r1sm41445149wia.5.2014.03.24.11.37.33
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:34 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id C1C68561521; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:21 +0000
Message-Id: <017771ed0508b247edaf875789260906f44381f4.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 11/18] bitbake toaster: check the file_name with the content of the IMAGE_FSTYPES variable
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:35 -0000

From: Cristiana Voicu <cristiana.voicu@intel.com>

File_name information of Target_image_file is being collected for a
.rootfs.manifest file. We would like not to collect this. The solution is
to cross check the information gathered for file_name with the content
of the IMAGE_FSTYPES variable. If any of the file_name entries does not
match the content of IMAGE_FSTYPES, we do not store it.

[YOCTO #5189]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 08d9fcf..30c9b92 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -615,11 +615,12 @@ class BuildInfoHelper(object):
         self.orm_wrapper.save_build_variables(build_obj, self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0])
 
     def update_target_image_file(self, event):
+        image_fstypes = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"])[0]
         for t in self.internal_state['targets']:
             if t.is_image == True:
                 output_files = list(event.data.viewkeys())
                 for output in output_files:
-                    if t.target in output:
+                    if t.target in output and output.split('.rootfs.')[1] in image_fstypes:
                         self.orm_wrapper.save_target_image_file_information(t, output, event.data[output])
 
     def update_build_information(self, event, errors, warnings, taskfailures):
-- 
1.8.3.2


