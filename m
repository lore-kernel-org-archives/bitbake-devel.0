Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
	[209.85.215.180])
	by mail.openembedded.org (Postfix) with ESMTP id 1F19C7FDC7
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:03 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id s64so27082308pgb.9
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=sHHC5spCdMcHMA8SiX5GYtNvF19WVafzS8tfmK/YS/4=;
	b=rI6bBlZo8Y9Fhp9d65chTdoqm5DFY9IHGh8NgNXCWU8wMK5Rh/F0VtTjCmdgb7Sho4
	SjAGtvPoGq9a9RXAaO6P7JT4jD8glkPDeZHg2vEeT22bKCVLQzxeQm38f+KWzNBLt+9A
	/YIyn6JRUufAtx6uH90xOIeRb/mzJYbxMeVwnsnfiCdBpuXAQPB5H0fTvqe8Lt6B90wP
	m/ysg6hUM6dmG7N/MF8BI7keE7kLxADUm3wm4NpXa9W/iCFkd33cPF62VUB65bXShF4p
	JSPqN6kTHon0jwQsAW5dLN5jw1LeFPugKnvw/HCo/+FMakP0jnErJIW6CbJnVW7/HJeE
	EV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=sHHC5spCdMcHMA8SiX5GYtNvF19WVafzS8tfmK/YS/4=;
	b=kqgHEGOUrV8zGi72dEklzIRbXFV/dBTx3jUo16UVloUndF4LD087SNMvxGQinTyEpR
	YN2odEyVKOvmYe3tCNlDjSOmB7PV3iq5gmQYj8dV+IN940eLTPfWWbQVJXBiSMGXEqGK
	pjPRDDt+7SRWJhHsxgH7PHxqsdrh8T0RJiVAZtuQORKK6X/gYNwQEbYNTs4M0uWuQ9uq
	y81Mux3c28tonvO5bUxxfRQIRv95BmrjY7WviCZx2S2jXxMFmydCaE1tlW2v60eKVv4A
	6wV9UrQqkgxj/cTt2Jdv2awX41BFX0PIjlyODRJQYZ1EKt+o8l18fSrL7x/O2PfxgejQ
	9KKw==
X-Gm-Message-State: APjAAAWnLC5rznA+DttJiXAIthM1EwKhWIU4YI0Vi8C9pzRoptyjZJqs
	13PEOs7gNWJ/Oza+RsBy/hiUTvrK
X-Google-Smtp-Source: APXvYqyTV/uYkfCcZhThdfhEl3hKdL+FDgt+96aDzhQC0hDWxmENo0grgV2W/2cABX4q4DpW37/yYA==
X-Received: by 2002:aa7:9510:: with SMTP id b16mr108771683pfp.65.1578328024284;
	Mon, 06 Jan 2020 08:27:04 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.03
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:03 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:35 -0800
Message-Id: <57df7f191755dd887827d51b125d246c1af3e1b6.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 14/25] runqueue: Optimise task migration code slightly
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:03 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Move the calls to difference_update out a code level which improves efficiency
significantly.

Also further combine the outer loop for efficiency too.

These two changes remove a bottleneck from the performance charts.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e28ec69356f1797de3e4e3fca0fef710bc4564de)
---
 lib/bb/runqueue.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2ba4557f..6da612b7 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2268,15 +2268,16 @@ class RunQueueExecute:
 
         # Work out all tasks which depend upon these
         total = set()
+        next = set()
         for p in toprocess:
-            next = set(self.rqdata.runtaskentries[p].revdeps)
-            while next:
-                current = next.copy()
-                total = total | next
-                next = set()
-                for ntid in current:
-                    next |= self.rqdata.runtaskentries[ntid].revdeps
-                    next.difference_update(total)
+            next |= self.rqdata.runtaskentries[p].revdeps
+        while next:
+            current = next.copy()
+            total = total | next
+            next = set()
+            for ntid in current:
+                next |= self.rqdata.runtaskentries[ntid].revdeps
+            next.difference_update(total)
 
         # Now iterate those tasks in dependency order to regenerate their taskhash/unihash
         next = set()
-- 
2.17.1


