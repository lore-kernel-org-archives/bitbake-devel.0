Return-Path: <akuster808@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id A3A3E70030
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 23:36:47 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id 21so2720539pfy.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id;
	bh=DOqBfJ/nkz+J1BSP/z1iXce9vFeLWYQ4dL9sFN5AMak=;
	b=Ixw8AWFxPYV7MsLE/RVumii74Bm4qW1NOx/4oxHzXHXMn4Z4yhAxtWR3GmPnPY4ZiR
	I52XWK4zFwR5oNahVEguHGHPD4iAa/WPg8OfhXEBUuUAj+VJQeFUwCQvn3+UFUPEDB7s
	9IgJupUBS+JsO0IN+sTjUb7gzzrsHwupAl4ceuKdBw0hdrtO2CcXdBZHA7fy7NZmn9un
	6QP+qiJlOqJfm1HElGX0NY3VkAisOOTl98Uq3dbNSEWYImeXP4P8QT04nrJv7SXFXfFZ
	s+qO5vBSg+BzzbeJ8P1IIk23mE1WRhvbuXgS6HtMKBOYfCzCIajLYFDQJ7XvjNn+FFIY
	2IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=DOqBfJ/nkz+J1BSP/z1iXce9vFeLWYQ4dL9sFN5AMak=;
	b=aa9xbxjHE6eq6hYI6aSMbUy3Q7zONuZ7h2btFYQeldkXUQvRJEMqROJrtjQzKCexij
	GfNxZT1vwX3+POA0X9fX4CPTdZVWYITjUdcUEbXrrrDIR1t2fCAu9BAD7exPLIY5mCeO
	BoZlMgrmAi7pQ1OZbvuuZDy8nnuhu2ANl9ak6rDTM8W0KRenP3fhniIyTiOtXMFlfPwp
	rc3TbqG60p6Qp6a2ZCREeybOKERyvG2fLWVhWUbrjcs+gUTd7JeNnCeNXFNjcQVKH9bv
	vfUTnic9PgAM24BGh3Dihr5jZJ5fF88ajEQzF/2Y/AzRq1Zl57cSR3tEXQtHwm9tTyDb
	ZgBw==
X-Gm-Message-State: AE9vXwPocpNgsAwl+hki525NaJp6SFjZm/eWVcOBi7YEQbvmQyRYdfz6jV3g/bCTLW0/kw==
X-Received: by 10.98.193.193 with SMTP id i184mr20214054pfg.69.1474069008003; 
	Fri, 16 Sep 2016 16:36:48 -0700 (PDT)
Received: from akuster-ThinkPad-X240.mvista.com
	([2601:202:4001:9ea0:142f:f172:55ee:c116])
	by smtp.gmail.com with ESMTPSA id q9sm8988434pfi.35.2016.09.16.16.36.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 16:36:47 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	akuster808@gmail.com
Date: Fri, 16 Sep 2016 16:36:41 -0700
Message-Id: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/3] Bitbake 1.28-next
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
X-List-Received-Date: Fri, 16 Sep 2016 23:36:48 -0000

Please consider these changes for 1.28
to fix bitbake-selftest failures.


Richard Purdie (1):
  bb/tests/fetch: Update cups url

Ross Burton (2):
  lib/bb/tests/fetch: remove URL that doesn't exist anymore
  fetch2/wget: fallback to GET if HEAD is rejected in checkstatus()

 lib/bb/fetch2/wget.py | 72 +++++++++++++++++++++++++++++++++++----------------
 lib/bb/tests/fetch.py |  7 ++---
 2 files changed, 53 insertions(+), 26 deletions(-)

-- 
2.7.4


