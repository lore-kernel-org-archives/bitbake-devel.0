Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
	[74.125.82.182])
	by mail.openembedded.org (Postfix) with ESMTP id 333BE6E760
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:10:58 +0000 (UTC)
Received: by mail-we0-f182.google.com with SMTP id p61so3515346wes.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=sXBGE4WU0EFZxJwV2F66UOHBapQA/WL8k1dVoITlwVI=;
	b=bAkhdWbWMgyy5y9Ox/safxl+RqXOWB26zaGmx71yNBX+kKCNcNxHg9BsvO8CIjOkPL
	cTuDOxc2UVZShTS4UEspvY4H+6lHP9yEUWydtw6ctubCYHpxkW678jAMFICIjw64Vhu9
	HCOy4nCtUe0G965WQ4hPTewpRVUmwkNCXwnxpCn7hU6ujyV2uZrfP8mOafLlu0PqLCwd
	HcAm1AegN8ScFZ0+/4ugfOz/RKWzX2rGZ1dRXWo8RpnyQw6jmlx+zUArLx16DUqgWfth
	avzAXdQP6CmScJ4RpBY40MT3ATLv2kge1J6Ox64HgBPKLY3WFdlOqjHSScdFdAf0Ws84
	Km8A==
X-Gm-Message-State: ALoCoQm4QCWVOUr2VkolTWbETcT1YgGatnnyyx31gYBQklDUdL8lBPIUJvAv3LWyEmKvmPKE5YVF
X-Received: by 10.194.60.37 with SMTP id e5mr12679712wjr.32.1396620659685;
	Fri, 04 Apr 2014 07:10:59 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	bl5sm12617600wjb.26.2014.04.04.07.10.56 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:57 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 8E2C65601FA; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:47 +0100
Message-Id: <bbe2bfb9c513107261faf24d7a20e482a7a9d2ea.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 08/14] toaster: catch IndexError error in dictionary lookups
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
X-List-Received-Date: Fri, 04 Apr 2014 14:10:59 -0000

From: David Reyna <David.Reyna@windriver.com>

In the get_dict_value filter, there is the edge case where halted
builds can lead to IndexError errors in dictionary lookups, so we
need to catch those.

[YOCTO #6067]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templatetags/projecttags.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 3dd0f3d..ee08ab7 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -247,5 +247,5 @@ def get_dict_value(dictionary, key):
     """
     try:
         return dictionary[key]
-    except KeyError:
+    except (KeyError, IndexError):
         return ''
-- 
1.9.1


