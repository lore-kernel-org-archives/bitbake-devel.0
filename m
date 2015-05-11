Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id 173026013D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 10:58:49 +0000 (UTC)
Received: by wief7 with SMTP id f7so83222127wie.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 03:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=rfaTMgYTiRELTJu1lg8CISRG1ZMhmdafUzD1Z25PnTA=;
	b=mum70UGMjfE0eMkYBkpc30gjV+WI4j83pK0KGJWMDkiYEjmePl3jQ2pCgNFJR8qAf1
	5DSdB0Hd3W0lU8PeDLODnGE/OLKyjtILTWyKssIFigqJgSkYbmFDz35P4lbxRjF7MYXc
	Fx3DCf5A2qvCS8EdjO9rM3+fIRMQwvMPTnlhUWXpvaQj3lZKEm0eABDoAtme7f8Oa/O+
	q1hyBK4mWE4IYj22i8cBzGdjjzOn/93b6TBw+GBo2KwuKzcPYZj91vE+GmBDZHksc9FO
	8OL9CUJdSioidYmUVD+Uws/0GCKyYI1GHMkh8e7F09ukcedRIZfjsIHIrOI7tJx0NsB/
	COUg==
X-Gm-Message-State: ALoCoQll1HWiKEMYZDoWa076WjZplEJhV1deG0aidncIV7yeWJGkKx/XiWjJdU4gHhO+YuhMJtiY
X-Received: by 10.194.62.132 with SMTP id y4mr19294482wjr.91.1431341930161;
	Mon, 11 May 2015 03:58:50 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id e2sm12706987wix.15.2015.05.11.03.58.49
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 03:58:49 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id DFDE75601A3; Mon, 11 May 2015 11:58:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:32 +0100
Message-Id: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1431338029.git.alexandru.damian@intel.com>
References: <cover.1431338029.git.alexandru.damian@intel.com>
Cc: Alexander Kanevskiy <alexander.kanevskiy@intel.com>
Subject: [PATCH 01/11] toaster: clear up toaster shutdown for mac osx
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
X-List-Received-Date: Mon, 11 May 2015 10:58:54 -0000

From: Alexander Kanevskiy <alexander.kanevskiy@intel.com>

This patch properly shuts down toaster in interactive mode
under Mac OSx.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 7907b57..792fb72 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -37,7 +37,7 @@ function webserverKillAll()
 			kill -SIGTERM -$(< ${pidfile}) 2>/dev/null
 			sleep 1;
 			# Kill processes if they are still running - may happen in interactive shells
-			ps fux | grep "python.*manage.py runserver" | awk '{print $2}' | xargs kill
+			pkill -U $UID -f "python.*manage.py runserver"
 		done;
 		rm  ${pidfile}
 		fi
-- 
1.9.1


