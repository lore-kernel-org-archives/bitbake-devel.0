Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail.openembedded.org (Postfix) with ESMTP id 5682D7BB93;
	Fri,  4 Jan 2019 02:42:37 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id f4so10331595ion.2;
	Thu, 03 Jan 2019 18:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=zztpz+J2f0XnFsWQW1zxu7KG/TluZv3jaVGfC0f5M8Y=;
	b=a6qk5T8TV35QtIgEtztr1p7ZbFWmsSQipNKOpHKWZRAkcghoZXCdvoq4P0sgZHs+zV
	sOdqLUxJeo4SH6nJ6jfe6UmfjVYsgrWHbC4ZaHcWNow6IQkM1SuWG8QO+SEsqe2ky4J4
	g7YvxVokO8Zv2Bt6c/Yq9RrFMplGa8jj8TzEhqe/qo/iK0YJGTOK1SesXrnlh0yr+J20
	m95qnXiLU/4RKZ1v6ghMFYRUJtOmgkd6I5vA6725BmC2ZQ9DDhK2GkY5/OrpRmQf5xDZ
	y/RB8QxSbkwazUUISP9QgAFiLSZW1pvJ0jULjNKglBAqUKeoy+u146p2zlFxoeYKpfwv
	s1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zztpz+J2f0XnFsWQW1zxu7KG/TluZv3jaVGfC0f5M8Y=;
	b=mNAkvaYYQdZ+C3+z/ssp3j24XW3fHIR0353cWgPXkoPszBJeSmUw3m1U0zvbe2ZKow
	oksJZBtk1Yf1MZgQ4IbcGlbEtoggriNNLoHpLVXAzA8v3FjTI6ZVYFQzLgLZazy9u57Z
	YFunezbAix5jiPfGwyHkOH/WJJoZjf2ol4Jvj5bo+fjlmOy/Xk4YiQ4uSYVrQ/EoI6Oe
	M/wVQFKyF4VLG1glnvRMySx5Z9/b6Y8YJ2VftxMjSDi+DCMEGuKonDUHVe7sZcGWQi+f
	q1n/s68XECQkjvxmEFhsgvlRa7HuWrkD2cVcf10yiv8cBKBmEqXS4n3hnHYQJbWVQAov
	qa2Q==
X-Gm-Message-State: AJcUukewG9p5im68xjIb77RLgD5z9OW9bmKsAa2oPE2CFZmkYXHcYVmC
	zqW8dFaRRXDPLpYnCUnGmhlBqHL3
X-Google-Smtp-Source: ALg8bN7KJ9gkeE3qzT+182GrU/G4YXRH9/+bhzl8chLpBwxzOrkDzNWjY6vfi4xfS5n/eVwkP96JLw==
X-Received: by 2002:a6b:7c47:: with SMTP id b7mr6215013ioq.122.1546569758109; 
	Thu, 03 Jan 2019 18:42:38 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id h2sm21864980itk.0.2019.01.03.18.42.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Jan 2019 18:42:37 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Thu,  3 Jan 2019 20:42:15 -0600
Message-Id: <20190104024217.3316-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104024217.3316-1-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20190104024217.3316-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v6 1/3] classes/sstate: Handle unihash in hash check
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
X-List-Received-Date: Fri, 04 Jan 2019 02:42:37 -0000
Content-Transfer-Encoding: 8bit

Handles the argument that passes task unique hash in the hash check
function, as it is now required by bitbake

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 meta/classes/sstate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 0abebce6996..8f3cd083e85 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -780,7 +780,7 @@ sstate_unpack_package () {
 
 BB_HASHCHECK_FUNCTION = "sstate_checkhashes"
 
-def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False):
+def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *, sq_unihash):
 
     ret = []
     missed = []
-- 
2.20.1


