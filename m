Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
	[209.85.215.173])
	by mail.openembedded.org (Postfix) with ESMTP id 14E0A7FC8B
	for <bitbake-devel@openembedded.org>;
	Sat, 25 Jan 2020 16:01:10 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id x8so2782849pgk.8
	for <bitbake-devel@openembedded.org>;
	Sat, 25 Jan 2020 08:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=6reVHDhjdxKvdEOqhe88fTnc7+FQVbq+UBFUnaV3P5Q=;
	b=McyPqJw3KQoNNEK7bp165Llt/llLBsIiIdKjjJrh0F73MGz/S3nSvtBSB7OTNu7Z/t
	dI0ZDliJI5i5nsfhvagmAM9ZAmcqfvzLSKinjMal6riZuMBsHNK4qCZle9UpNhR0BKky
	tn9hJ05Iwv8AwOBPjnzBO9zRa6Ij5CRuf2Zt/HUC2TJammnmoh8On5jZMMtenQcsiEmv
	IIdhHdB4chqmQMNdrx/9G5QEKK9AK5n9EbnCR/kwSSTkUjskHh5gT1AZ9rBr6D4Khzw5
	LSqSjWfl/+Xor5lZFa5Bs3rKuUz5kM4jTi05MR7qS2iNO23rsQTFC5fWt0T6TYBDwAWC
	UHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=6reVHDhjdxKvdEOqhe88fTnc7+FQVbq+UBFUnaV3P5Q=;
	b=S+aoxU5/IXh5scxmOwst0hzA6BPevXS3DTuYu4SGQblOqeotT37jGXx+LPk4Atlkt6
	4iPcaeuDVXnMreVLmSi2eFY6XUq7mw3CU5k0Tx+GSGIxTZ3rPvZQMZ1QwfH/BMJeIdVN
	wD0a1/5QEpZ4jDIr29edTPUvQ/EvQc7KTT9xXyJdclzPJ7L5d+OyPO7O1vzb4Y6IYKrc
	sgso3Yn8nkMGH7miSeZvOW7IEFvlK9o3yFQqPYnE1FXOsFJDOAOTbM8R9+xVronzFA/t
	0zmnbkb3YiqN9RmEWzTMG1KkgvvndmzBCwHjFvNsZ32XxLz3OStcaokmwcYvpiDlWmpW
	5H4A==
X-Gm-Message-State: APjAAAWqYb0bv0kcSJYHdyMlWtRHsQjGe0EJiUBFVXranFqqRrs8W70e
	IyfG6c2ki7xTbACHhzA+Ao5Ai1qB
X-Google-Smtp-Source: APXvYqwt/UoNUeCOfmGfF3DAB1rPYKCUEhPclFwEkaYsCXMJEForEkMAtDJpobGdxoYK+gWVbRIIjw==
X-Received: by 2002:a63:4d1b:: with SMTP id a27mr10011167pgb.352.1579968071985;
	Sat, 25 Jan 2020 08:01:11 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:953f:6ade:6955:1d1c])
	by smtp.gmail.com with ESMTPSA id j9sm10291064pff.6.2020.01.25.08.01.11
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 25 Jan 2020 08:01:11 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sat, 25 Jan 2020 08:01:04 -0800
Message-Id: <cover.1579968003.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [1.44 0/4] Pull request
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
X-List-Received-Date: Sat, 25 Jan 2020 16:01:11 -0000

Please concider these changes for 1.44

The following changes since commit 46969195492708a705390896c9dea515f158954c:

  cache: Lower debug level for wold build messages (2020-01-02 20:23:09 -0800)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.44-next
  http://cgit.openembedded.org//log/?h=stable/1.44-next

Peter Kjellerstedt (3):
  cooker: Keep track of watched files using a set instead of a list
  knotty: Hide the footer if a process progress bar is shown
  knotty: Be consistent when creating/updating progress bars

Richard Purdie (1):
  runqueue: Use a set for the setscene tasks list

 lib/bb/cooker.py    | 16 ++++++++--------
 lib/bb/runqueue.py  |  4 ++--
 lib/bb/ui/knotty.py | 17 ++++++++++-------
 3 files changed, 20 insertions(+), 17 deletions(-)

-- 
2.17.1


