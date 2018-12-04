Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f174.google.com (mail-it1-f174.google.com
	[209.85.166.174])
	by mail.openembedded.org (Postfix) with ESMTP id 8EE506C562;
	Tue,  4 Dec 2018 03:46:33 +0000 (UTC)
Received: by mail-it1-f174.google.com with SMTP id p197so12298446itp.0;
	Mon, 03 Dec 2018 19:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Hpg08217qaDvW3v0rSsO6eM9feSwhKOa18UfzHvBh6M=;
	b=nyA1Db0zrOYYgQkLm0EXeyKHI7JMo74Wp0NE+By6ERIUvOZSp5dGLz0byCaIxK+n7j
	UDEgM9my5tIWlEM45eeBBV6nzdpjrJj67pVH3IFkHNnqarctG9crw+7nA4wLcksqV+sC
	el82Tslb7Q9NxivmVe1fQ+3FjTtLPq1PcNrje5lrfls1W8hMtt4VBDzNkhQ63KL3h1PB
	UfyRQQE3hs7h7AEvxuqG0YqCnp9xAZctgkCkzH0xFMBMuNdfLI0hhWAijDMaxFskDUlP
	JQT612ehFdHXSzwQgjerQjG76Mb1pQKi9eIb6imFVye0uUyzZho6Bm4IKqJzr+8668hN
	P1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Hpg08217qaDvW3v0rSsO6eM9feSwhKOa18UfzHvBh6M=;
	b=r6Q1oqMuCveFyHVsOPGWa1bGJ4NQS+UWobmVRIh+TKVrTkHtDr/h+Kbjyc1BjC6Yr7
	LeCAPCnfZVjUrTbbUZjX6iYz6891AgtzFGOMmUzow3T4av5lCXM0nOMTzOvNlo8q+t3F
	LuYbjp96WrAeE9lCkBSkDj2+d42Ufg/ajrOBJSGNh9s+1/AxIS+2GTwfBTErM7AwLJpX
	//S7QFHMzVhetuuGGua+qUgvQb9dhaMHryhaDEpgX7OSurztc7RnSWs3quDEy9bAOQ2J
	9IHPua2i5kKomuqESZjJkc8EqS+dvWdogytsnUW4YkGsUfilXTioH0338JNeUjv6qH9V
	ljPw==
X-Gm-Message-State: AA+aEWacgVPrOx8lZ0XZFZ4CrP0XAzsG4jG0oAfbpY/mg1uSvxjbF9dM
	wmda9TnWH91l7z92K/BFV5ij/0Ddsrk=
X-Google-Smtp-Source: AFSGD/WyCWK+5Xs2rrNltvbrbs6NJandaQVyWRNFQknxPkEZokIxDYRLsfAEVda8pUOTgdQT+y4F5w==
X-Received: by 2002:a05:660c:128c:: with SMTP id
	s12mr8298139ita.145.1543895194432; 
	Mon, 03 Dec 2018 19:46:34 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:33 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:42 -0600
Message-Id: <20181204034245.25461-15-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 14/17] classes/sstate: Handle depid in hash check
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:33 -0000
Content-Transfer-Encoding: 8bit

Handles the argument that passes task dependency IDs in the hash check
function, as it is now required by bitbake

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 meta/classes/sstate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 8b48ab465fd..4b91ff472d2 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -774,7 +774,7 @@ sstate_unpack_package () {
 
 BB_HASHCHECK_FUNCTION = "sstate_checkhashes"
 
-def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False):
+def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d, siginfo=False):
 
     ret = []
     missed = []
-- 
2.19.1


