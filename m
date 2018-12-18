Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f196.google.com (mail-it1-f196.google.com
	[209.85.166.196])
	by mail.openembedded.org (Postfix) with ESMTP id 72E047C05C;
	Tue, 18 Dec 2018 15:31:18 +0000 (UTC)
Received: by mail-it1-f196.google.com with SMTP id m62so4709015ith.5;
	Tue, 18 Dec 2018 07:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=vKAPFHJ34Q0s8twWhRON9GptS/wooWWjTMlFW1//FqU=;
	b=uuvWTM4LgPZlgVnjpeA/87ZptvNamCCdQC5+v7FCKR0zoG4wFepVex33LLX4foHPQH
	qGoM4c14LVbeE/uFd/A3OoOsfgJ2ka76I/PLkopKAHxJG3K4c4QtljmdeJVmKn+3p1bi
	Y+Xb3g2/sFycCX5WI3WSuMKY0AgmaZLyPgzFQJ7qtoqb3T2sYYiDwcUokjIZ0U2s1cOX
	/72dPdlSxtuSDimhMBYIL3D+kOaO8THQoidMGh4eQBtdVqxtlkZ+WlQgzaqBybSmUspk
	hn792cPOfOUIvEOyqEe6KWHzuPqAoBDTU2dtDEJLsG8tFpX0lDexNrS9kbkD/PbKqJ6S
	z6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=vKAPFHJ34Q0s8twWhRON9GptS/wooWWjTMlFW1//FqU=;
	b=ts3/sCkPV5pak+3+5hVYC+ppXL09Z+WfGiwQurSxttti68elED5r0wPLzCgjWfRY8X
	rcTLztiG4O0eWpvO1DCo94mRi+TIk7bSu5Wv4f/gbHnzfX4qpXInRnMWdv3u6TC8cqD1
	F3T4zKgRV0l4CfBLn9bs/eG3RteSxIDJ+Qychf3m9MfSsu4Nb7K4McIpgwVbcGpXwsQS
	2ovADFQWXGDAkD6yJx+4ab10wyD/ztUV+rkTZ/RBlLJbNllvMiKPPjUPaocPK7v9MVSo
	h1J/XK25zQhnmJn8ARzoWsrz9859CXNO3Pi615OJiqCT2Xa6aOQGmQ2gm6i23dKCc7Wv
	MPAA==
X-Gm-Message-State: AA+aEWZa32OR8XA7KKBiiglPPkeTiLqiqMUkEQW8ErUN1aNordXknAr8
	n/lUwb+bDmCocZ0MlER7yFnufISP
X-Google-Smtp-Source: AFSGD/XevIpJqz0a7GvQ6bsP6ypIjiLC/+xIAHj/QPCpjtijXmgkx5Lr8nkXyz0R804EiqYyBegP4g==
X-Received: by 2002:a24:390a:: with SMTP id l10mr3242036ita.0.1545147079170;
	Tue, 18 Dec 2018 07:31:19 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id 18sm1652072itk.28.2018.12.18.07.31.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 07:31:17 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 09:30:59 -0600
Message-Id: <20181218153101.9212-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218153101.9212-1-JPEWhacker@gmail.com>
References: <20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181218153101.9212-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v4 08/10] classes/sstate: Handle unihash in hash check
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
X-List-Received-Date: Tue, 18 Dec 2018 15:31:18 -0000
Content-Transfer-Encoding: 8bit

Handles the argument that passes task unique hash in the hash check
function, as it is now required by bitbake

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 meta/classes/sstate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 8b48ab465fd..41a2f9b7b77 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -774,7 +774,7 @@ sstate_unpack_package () {
 
 BB_HASHCHECK_FUNCTION = "sstate_checkhashes"
 
-def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False):
+def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *, sq_unihash):
 
     ret = []
     missed = []
-- 
2.19.2


