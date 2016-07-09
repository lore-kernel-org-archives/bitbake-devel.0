Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195])
	by mail.openembedded.org (Postfix) with ESMTP id 7BE3273189
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Jul 2016 00:52:52 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id i123so9386185pfg.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Jul 2016 17:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=INnHSaSfOvNnMMN4+ytDljYDBW9ahBPiT6Fg0hkvBzI=;
	b=Zd9RJ3MBkdCvNNXg5uWg+L31IupBoQ/IVmqR3H05KE8QuWpjTOltMAnTZJDTJYn7es
	3C6LJggfKDLTlwmlk694WUybXmBNYDPuBSxKeDkAtk4DJQ7nX5sfUkxdHVOD1RAbV9tU
	HRmxn5DZiwFB0Q0Kvyi2QVUXe5LMLpLbtk6X8f39Jl4LMC4MlFDQswbMxeXKLepaNIV5
	YuPl7nyNORpWufl5VL9bwSApqrVM8eDvU3BsO9DRnX7V3520stgntRCys2U3XbSrFM5Z
	tb2NbrcFA+UQcbSJXjQCrd2+nbnnnaYYWInzo6B6X59zTR7W3il1dJpIsCEuz9mgIYTb
	53CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=INnHSaSfOvNnMMN4+ytDljYDBW9ahBPiT6Fg0hkvBzI=;
	b=aooGkIS2NlNlyzsRg4khhxx3QJ2zqwfZBRWFLOi4h176xJEf9YL+Zt+2Fs8qdsu1y4
	3IYbppk85lWmjbvkAT5cIZFrxw4kxfL2Mh6e+S4Q9G9K9SGNXK8ObsVgLfqG1Pgj+VwB
	om49EY5lI7ysHbHwaJuKMdh9NOQuk47cJiaQKDR5/sc8kmCBHAtYLkp2r4arY+0uQJqZ
	nTPs4UKr993JnflODd7MOFymdBu5N0UE4nqbXNypQQTNlzMverpGYxggvgvMO0VCYGsE
	lTFzzuW/2o/FtUOU+EMxI19EOA9oTrEO4cgBXSCRm/Iii2L/vK93Gw1KxlWzFMQOlFqG
	dV1w==
X-Gm-Message-State: ALyK8tKwtyBlsQT/zGdpfHn6wDd1WWFk+kQ4Mj+kr8NeAEbpnThQr+/rMWklYVNic5/n1g==
X-Received: by 10.98.134.15 with SMTP id x15mr14445474pfd.21.1468025573309;
	Fri, 08 Jul 2016 17:52:53 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id bm8sm213836pad.10.2016.07.08.17.52.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 08 Jul 2016 17:52:52 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jul 2016 17:52:44 -0700
Message-Id: <35603a8529f2399ac5e9336eac0faaa184eafa01.1468024992.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
References: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
In-Reply-To: <cover.1468024992.git.brian.avery@intel.com>
References: <cover.1468024992.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 4/7] toaster: improve image file suffix retrieval
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
X-List-Received-Date: Sat, 09 Jul 2016 00:52:52 -0000

From: Elliot Smith <elliot.smith@intel.com>

Refactor retrieval of suffix from image file path, making it a
a method on Target_Image_File. This makes it easier to use this
in the build dashboard for individual images, plus reduces the
complexity of the code required to get all of the image file
suffixes for a build.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/toaster/orm/models.py | 48 +++++++++++------------------------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 61737c7..40cdb9e 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -440,51 +440,21 @@ class Build(models.Model):
         """
         Get list of file name extensions for images produced by this build
         """
-        targets = Target.objects.filter(build_id = self.id)
         extensions = []

-        # pattern to match against file path for building extension string
-        pattern = re.compile('\.([^\.]+?)$')
-
+        targets = Target.objects.filter(build_id = self.id)
         for target in targets:
             if (not target.is_image):
                 continue

-            target_image_files = Target_Image_File.objects.filter(target_id = target.id)
+            target_image_files = Target_Image_File.objects.filter(
+                target_id=target.id)

             for target_image_file in target_image_files:
-                file_name = os.path.basename(target_image_file.file_name)
-                suffix = ''
-
-                continue_matching = True
-
-                # incrementally extract the suffix from the file path,
-                # checking it against the list of valid suffixes at each
-                # step; if the path is stripped of all potential suffix
-                # parts without matching a valid suffix, this returns all
-                # characters after the first '.' in the file name
-                while continue_matching:
-                    matches = pattern.search(file_name)
-
-                    if None == matches:
-                        continue_matching = False
-                        suffix = re.sub('^\.', '', suffix)
-                        continue
-                    else:
-                        suffix = matches.group(1) + suffix
-
-                    if suffix in Target_Image_File.SUFFIXES:
-                        continue_matching = False
-                        continue
-                    else:
-                        # reduce the file name and try to find the next
-                        # segment from the path which might be part
-                        # of the suffix
-                        file_name = re.sub('.' + matches.group(1), '', file_name)
-                        suffix = '.' + suffix
-
-                if not suffix in extensions:
-                    extensions.append(suffix)
+                extensions.append(target_image_file.suffix)
+
+        extensions = list(set(extensions))
+        extensions.sort()

         return ', '.join(extensions)

@@ -658,6 +628,10 @@ class Target_Image_File(models.Model):

     @property
     def suffix(self):
+        for suffix in Target_Image_File.SUFFIXES:
+            if self.file_name.endswith(suffix):
+                return suffix
+
         filename, suffix = os.path.splitext(self.file_name)
         suffix = suffix.lstrip('.')
         return suffix
--
1.9.1

