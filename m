Return-Path: <pascal.huerst@gmail.com>
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
	[209.85.128.46])
	by mail.openembedded.org (Postfix) with ESMTP id A6C156B073
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2019 08:28:19 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id p9so2114230wmc.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2019 00:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7CjhtL/IKMa0NhLOBdnGCVseIrmWadNNiHvZWFz2Y+A=;
	b=u6aR6V+Lb7IpLOZdzOr1sMswA8X/E7Pee4F+il3hpJn1nAxy+mR8OLw44YMR7EcyEG
	uOKbRCQqk5srv2no1ePEII/3WhS5n4SdDhJC/xKx/iKPtDi2t3zyhukDSdl1wR9KmUUb
	jGzGcZDoxCN/Du776EWw7EH4pxuZqSblHQSBkNE/VACdy0lOiHS7G3Z/KAlbY3pz+PO8
	sl4A7xoPfezsc/zcb3GmEueXqxdkNW0tox+rG+JqSO3e8YE/ULg+SSFb4rWPosSyC0SH
	Pmaz3O74aJ6cAp+AhisBbMWi95BCuD+NtXwFkat0DzowbrN0+9ZCuTmkpRVyAwmdPgk/
	VkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7CjhtL/IKMa0NhLOBdnGCVseIrmWadNNiHvZWFz2Y+A=;
	b=tyu8qE2w+eMfL1BpDJim/iy8ZHBjNHtn4Lu76+Jz0Wntd762HPL4W65upAYOZPZVRU
	dik71tt393Vb6awq79S4FRxEGGCgKvtuUsZgiw1dUnw6XRQbKVGlKao4Rq3rFbcwfxsu
	RW8JI6w/WSuU3VvMvaPlIpv73illis6kN8dste23X4enlJPDTw/L43Qs+Gnh+TFJUGid
	9nTXoDVIi60PcUavCO/kwOQ+0LtYtp9rXL7BB38zNfXAiHwOWzBk2cWDq4k6As0cC7oB
	hF0VjVY1x47TJoPmq8Qhz6HuzEbA/VHvyUKW1x6Gk57RCn4+a/hWWuJkygEK5Y3H21Dh
	9vRg==
X-Gm-Message-State: APjAAAX8lJrwbuDWkwEC/uGWnAxy6t43H/W3sG/255J+vmqqcODmkkvp
	iYuGiJhE4HtytF8ZsFMw4ieVP2BX
X-Google-Smtp-Source: APXvYqwYUIo1CS2CMT/OvEAG0Aw1q6jZw+UJ6gFFtZO18ilb13ShcMK/QFHRapte1A8pbSPsVo8w4A==
X-Received: by 2002:a1c:7310:: with SMTP id d16mr3550753wmb.165.1575966499926; 
	Tue, 10 Dec 2019 00:28:19 -0800 (PST)
Received: from t470s-local.localdomain ([194.162.236.226])
	by smtp.gmail.com with ESMTPSA id l3sm2409735wrt.29.2019.12.10.00.28.19
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 10 Dec 2019 00:28:19 -0800 (PST)
From: pascal.huerst@gmail.com
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Dec 2019 09:27:59 +0100
Message-Id: <20191210082800.20779-1-pascal.huerst@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Subject: [PATCH v1][RESEND 0/1] bitbake: fetch2/git: add SRC_URI option versiontag
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
X-List-Received-Date: Tue, 10 Dec 2019 08:28:20 -0000
Content-Transfer-Encoding: 8bit

From: Pascal Huerst <pascal.huerst@gmail.com>

This patch adds a new option to SRC_URI to fetch the latest tagged release.

We want to fetch the latest tagged release from our repositories. Bitbake
already comes with latest_versionstring(), which fetches the tags from a
remote, using ls-remote, sorts them and finds the newest using variable
${UPSTREAM_CHECK_GITTAGREGEX} which can be used to set a regular expression.

Please let me know what you think and what could be improved, or if there is
a better way to achieve this.

Thanks,
Pascal


Pascal Huerst (1):
  bitbake: fetch2/git: add SRC_URI option versiontag

 bitbake/lib/bb/fetch2/git.py  | 24 ++++++++++++++++++++----
 bitbake/lib/bb/tests/fetch.py | 18 ++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.23.0


