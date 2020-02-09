Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
	[209.85.215.174])
	by mail.openembedded.org (Postfix) with ESMTP id 50FFB60D1F
	for <bitbake-devel@openembedded.org>;
	Sun,  9 Feb 2020 16:03:20 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id b35so2498812pgm.13
	for <bitbake-devel@openembedded.org>;
	Sun, 09 Feb 2020 08:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=IgcAKPRW+3/BKYjgf+qvn+tomuP+rx4SEmjKYBXqRR4=;
	b=NEc6pHGKNwjMHbKsYuSZvWURnPTS0W36cj42CvxRWkJH0A7mZ7LSWrS0GsBGgr5zKH
	Id1EBMb3vqv4Q7Jm9S+EUkxXYs183W1IA21+oP3t5j2lN+uWr2vGs07YVK4pyRfpmbvP
	P2KjDYGVe/Zp3sjQYaqkuobsJOFGpluoxTXDXM3MOOYkmpRTOhHKiXrdRB0MRCWIkKh8
	ZW6E0CL43XhvNIu7HHKz0lHpDOSUxxAU5GW0R+312pJ77HUeRNRD/Pr6iTGwR2kke6OB
	1TIZqbZ2WDnStocu27z7NHQq9JaY18AwucwtEes70joX39iWKgVYqDbHfRd9Orgxm17W
	2ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=IgcAKPRW+3/BKYjgf+qvn+tomuP+rx4SEmjKYBXqRR4=;
	b=fWsX5kJNkOL4HAETn6bgGPjW1irnsAvlJceBZ9MHoxwsrrVvz72rpLvvvCfMtisA/l
	q9G6N5Thpzu2jVei5mGT9hE0D5Ku3oP0qQ12c6c/JwIaLMdkO7fyd7fAkM/TFTnJ1xZ7
	FzmokOKBppUNzZqL/1rCRVBvFxcOWDo4n3LD0GJlDtH+S5AGg+fzGVdEwqVqmJouPnYz
	aQe3f9ky4kwZUD/kjUH3aWEg0vKy5zxc0z4G3ls4pJhcAwxf+BPwXIzypaKrBheVsJFY
	mZtXT8BMAf3NS+icAGfSlHFtTyly32VmEsy9Fq4tO+3Cl/aKUb5K0nVmk206wXoM//ie
	2ehg==
X-Gm-Message-State: APjAAAVQGTWH+SVwd2o65WTXAfXLf7pPqzWIgz9b2/eZVpe5sQhdAUIg
	T1tplrXyTjw48eIN6cIy5VWz5FlZ
X-Google-Smtp-Source: APXvYqxoB7sTrlrC6E0+JGWM5CRMktyj6TN6PAOl5TcmvyzqhO0pkXAmlmhMLaHWjdshBnpzorfM4Q==
X-Received: by 2002:a63:5508:: with SMTP id j8mr9568133pgb.170.1581264201270; 
	Sun, 09 Feb 2020 08:03:21 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:154b:3780:5122:4aa9])
	by smtp.gmail.com with ESMTPSA id d3sm8529353pjx.10.2020.02.09.08.03.20
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 09 Feb 2020 08:03:20 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sun,  9 Feb 2020 08:03:11 -0800
Message-Id: <2ba2f224b50956313f5c2ba01942143b4d6098f2.1581264053.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1581264053.git.akuster808@gmail.com>
References: <cover.1581264053.git.akuster808@gmail.com>
Subject: [1.44 3/7] persist_data.py: Immediately get exclusive lock in __setitem__
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
X-List-Received-Date: Sun, 09 Feb 2020 16:03:20 -0000

From: Chris Laplante <chris.laplante@agilent.com>

To avoid races, SQLTable::__setitem__ needs an exclusive lock for the
entire transaction, not just the INSERT/UPDATE part.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit feb43e7c30f5bfab75d718896c45df621810d06f)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/persist_data.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index de8f87a8..7357ab2d 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -179,6 +179,9 @@ class SQLTable(collections.MutableMapping):
         elif not isinstance(value, str):
             raise TypeError('Only string values are supported')
 
+        # Ensure the entire transaction (including SELECT) executes under write lock
+        cursor.execute("BEGIN EXCLUSIVE")
+
         cursor.execute("SELECT * from %s where key=?;" % self.table, [key])
         row = cursor.fetchone()
         if row is not None:
-- 
2.17.1


