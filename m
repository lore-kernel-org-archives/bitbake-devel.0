Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 9013860616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:35 +0000 (UTC)
Received: by pabfh17 with SMTP id fh17so48537097pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=ZEEbKPIQGvMnv3sDb4vzmVCiihysFRAW7VEEkV+K4o8=;
	b=v7Hc4XUzpKZ+9ppkUsMwXrLyG4AIZ96Cg/FTgeHWLDzoIj6vX5IN5EAf4YWs8uSQPW
	4To+r3ySusZjp9JnokzSJDD8i6RIJOKytqb0pxQc/BAHCAfmUkX3nLykkuF4m9h8pRCG
	OmapPtGp0LQ1gESTl46w+992WjSMljZu+xtwzg4Jzqu7a/k1cQMBUDliZ94TewxThNe/
	UMKAnjw+3nFRBii3nq7raFqaPulwm4PmkTwyfir6Qk8LfUnWsRi6LwANjkhrmaKaG9cZ
	8kq0zMwOf8b4KUKWDcaH9KJ2Sc0TlEeYQESKoAgPbvBPE3DedIeRxUhUe9KTbprztWem
	VK7w==
X-Received: by 10.98.15.67 with SMTP id x64mr6561426pfi.67.1449079176643;
	Wed, 02 Dec 2015 09:59:36 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:35 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:37 -0800
Message-Id: <43de04cb1abe40187d42e2bc0f20ba9ee200f3b3.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 05/30] toaster: remove unused variable
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:35 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed variable RUNNING as it's not used anymore
in the toaster script.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index abc8737..1ce4af7 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -176,9 +176,7 @@ fi
 
 BBBASEDIR=`dirname $TOASTER`/..
 OEROOT=`dirname $TOASTER`/../..
-
 RUNNING=0
-
 NOTOASTERUI=0
 WEBSERVER=1
 TOASTER_BRBE=""
-- 
1.9.1


