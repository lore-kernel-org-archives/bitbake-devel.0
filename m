Received: from mail-vc0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jon.szymaniak@gmail.com>) id 1Tkboh-0001zf-FV
	for bitbake-devel@lists.openembedded.org;
	Mon, 17 Dec 2012 15:37:15 +0100
Received: by mail-vc0-f175.google.com with SMTP id fy7so7022119vcb.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Dec 2012 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject
	:content-type:content-transfer-encoding;
	bh=mS3MDorqoRuPoQ51gZ/kLqcPA8+qaN/Xkz/yZUTgTto=;
	b=biZ2NCyEl+jyoOFj8vAyQaEpqPGsmaq4nXTUtMBBjfn9Rq16KDZ8vrWc58znwqerMk
	9o7gXMqUcSzA65f/2J49ytvZ8oli6mOFHxivaAE/eo6gNYtO045605d+YukOhOVfyTdb
	bUNUNVIrmyybNLSex9UGMLBJv8tcArm8/qmmThQXZIo22laaVp3UUcan0aHRNZciUFUO
	vfKJ9yVX6hZjkRmWBcoakh9itdyrMMz5o8cyjAt1tR0/aPdVVl2yJk3lM3pzfg9OfSnD
	Ly28dFINprlq0pxFkh3agX6dlozGMtt0JHMcMKtE9Aw/RzrhcKzYmjfj6AnENM9vDV+/
	PU/g==
Received: by 10.220.231.65 with SMTP id jp1mr22897660vcb.30.1355754154633;
	Mon, 17 Dec 2012 06:22:34 -0800 (PST)
Received: from [192.168.0.76] (static-173-85-240-166.fnd.frontiernet.net.
	[173.85.240.166])
	by mx.google.com with ESMTPS id gl6sm11434562vec.4.2012.12.17.06.22.33
	(version=SSLv3 cipher=OTHER); Mon, 17 Dec 2012 06:22:34 -0800 (PST)
Message-ID: <50CF2ABB.2000002@gmail.com>
Date: Mon, 17 Dec 2012 09:22:51 -0500
From: Jon Szymaniak <jon.szymaniak@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:16.0) Gecko/20121028 Thunderbird/16.0.2
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/1] hg.py: Fixed fetch failure that occurs when SRCREV is a tag.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 17 Dec 2012 14:37:15 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Removed "-r REV" from hg clone invocation to fetch the entire repo,
rather than just the subset at the specified revision. This will ensure
that the specified tag exists for successive commands (e.g., the update
built on line 149.)

Signed-off-by: Jon Szymaniak <jon.szymaniak@gmail.com>
---
  lib/bb/fetch2/hg.py |    7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 155ae67..be0ef3b 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -98,7 +98,12 @@ class Hg(FetchMethod):
              return "%s identify -i %s://%s/%s" % (basecmd, proto, hgroot, ud.module)

          options = [];
-        if ud.revision:
+
+        # Don't specify revision for the fetch; clone the entire repo.
+        # This avoids an issue if the specified revision is a tag, because
+        # the tag actually exists in the specified revision + 1, so it won't
+        # be available when used in any successive commands.
+        if ud.revision and command != "fetch":
              options.append("-r %s" % ud.revision)

          if command == "fetch":


