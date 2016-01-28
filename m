Return-Path: <armccurdy@gmail.com>
Received: from mail-ob0-f196.google.com (mail-ob0-f196.google.com
	[209.85.214.196])
	by mail.openembedded.org (Postfix) with ESMTP id 061D076EBF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Jan 2016 00:43:38 +0000 (UTC)
Received: by mail-ob0-f196.google.com with SMTP id wg8so1447603obc.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 16:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Pnd7DNh2ZnmQQoI0EEd0nr8XFqRSco3Q4EiK9JID1P8=;
	b=X9ksBXKVoDzlA82VbuKNgb/5YuuCcYu3UvWFb5bGmfeIffvTZK5ZtEm4MUVrKpzUJF
	NJwuxsx7eM3SRmaJQpSt08x/ivUQZ+d+KsB2akeuaN87atk6tiBU9bD1x/IJ/zpGP1L5
	Odaa2BM+paUnTtle/kv8Q9BhUlb0khRJ350EtsE1Y98UxfQHksULTy4haDPFl1qn7Dli
	yWCnx52AU/rAwl7MKi6wavglXI8NHuiSwvchOH/yKaLvMzfrwMZzp4oiHV+/alNLqJQZ
	ZLbQt2TrAIGSfoxroiq4ebZnui4K4lBIsuQMrhulmb8zGOt8PRmU6alId6aXdfPkJHhV
	Skjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Pnd7DNh2ZnmQQoI0EEd0nr8XFqRSco3Q4EiK9JID1P8=;
	b=LAuhN20wcxzXMWZjTzp5vUsKT10WUX+XseCNITgUYmXiBDorFkNhr5/UnImPuj9q2W
	5skh78tymvR2QcdjzMnWFt5+UBjP91A26Zu1b++rJ4dIklWMtzs0E8ulp7ZM3P8G4KAj
	9Y/VmUvS2FLc1vNmJQNkYgTAgOiEaDDKU6o0wBWUYsZOBfW3Z+GETwVXpzgCYIyYk+FW
	3g3wEn7V1IhYU/1AByPeHUof+1gInqfGzKm2nQXKUmLAre6APdAcmJtEym7KmpFbOHf7
	xnq8Xqh+rKPkazCnT0HrECRlRpsiDl2Ndm4whpalpVUi2wkmm6uMt/ARWVwDlodw39hp
	cpcA==
X-Gm-Message-State: AG10YOSE6K10VSEMgdmNnXMM86xB9JGWQKK/LEgA4pqJxFaAyJkPuN3tn5OLxyHCTgK5vQ==
X-Received: by 10.182.115.196 with SMTP id jq4mr135800obb.48.1453941818963;
	Wed, 27 Jan 2016 16:43:38 -0800 (PST)
Received: from e6520.cablelabs.com
	(50-204-102-64-static.hfc.comcastbusiness.net. [50.204.102.64])
	by smtp.gmail.com with ESMTPSA id h1sm4274956oek.11.2016.01.27.16.43.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 27 Jan 2016 16:43:37 -0800 (PST)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 27 Jan 2016 16:43:16 -0800
Message-Id: <1453941798-11670-2-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1453941798-11670-1-git-send-email-armccurdy@gmail.com>
References: <1453941798-11670-1-git-send-email-armccurdy@gmail.com>
Subject: [PATCH 1/3] build.py: minor shell_trap_code() formatting tweaks
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
X-List-Received-Date: Thu, 28 Jan 2016 00:43:38 -0000

Fix quoting of $BASH_COMMAND and avoid wrapping at 80 columns (the
script which follows is likely to contain some very long lines, so
line wrapping in bb_exit_handler() looks somewhat out of place).

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/build.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 8852209..4a48a61 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -277,9 +277,8 @@ bb_exit_handler() {
     case $ret in
     0)  ;;
     *)  case $BASH_VERSION in
-        "")   echo "WARNING: exit code $ret from a shell command.";;
-        *)    echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from
-  \"$BASH_COMMAND\"";;
+        "") echo "WARNING: exit code $ret from a shell command.";;
+        *)  echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from '$BASH_COMMAND'";;
         esac
         exit $ret
     esac
-- 
1.9.1


