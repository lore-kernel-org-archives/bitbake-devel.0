Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id 98ECD7D084
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2020 08:23:28 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id b19so1926985wmj.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2020 00:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:user-agent:mime-version
	:content-transfer-encoding;
	bh=JFjQI5j0ZISCZW+inI5xiUKYE88GDXepJuJJmLjInxU=;
	b=BlpWSC3NZ5HaBYQnBg5NhdleriLUx7DzoErbomVB0ogmCFHgA+yFoBlTe9RnFifCo7
	QCGNexxyaKCnbeWuNAW7r5BD7gUhTDCLXgEtqAid74YQWoSzpomreer5fqlxVAY8p3vq
	UHZYYXVdNvZVqnSXolyT3lV73wU6+lVCRKrDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:user-agent
	:mime-version:content-transfer-encoding;
	bh=JFjQI5j0ZISCZW+inI5xiUKYE88GDXepJuJJmLjInxU=;
	b=FNWT/EpHq0d0anhpo67E+YrAby6hXBCPHoVi/wvAutSNTNMz8k0vhHu6RjecqUxELV
	GcnD0f/EevKlniMimuVwm72mIrh/olX90zpcuGS1WZKRlVVp72W9XwJs0bNan1RRiDI3
	8asIdux7OzDcXI2Pc/GX/7My5mlBV3BV17p2I/WcqwSzZ5aHy6dduNy8rbAGZxDDN9lO
	/mDkSvdHkhKsDrGHkW7w8NG5aUXQq+jVh6ufECeHCakbc0tr0tXjP9GirYRmN8Wgp3de
	y8RI4McEanS+CZtmmnOjvaKmmvYFaBdmIJ5xWtHPZOkWCTOZGdqXGnUgeS3mNyyxGsTw
	OgZQ==
X-Gm-Message-State: APjAAAWhWYcqaYqUZ8LDRLBby/8Ewkm1bCSQs97rzCHUBT9q1qgz4RQk
	86QHodj6LnFiWJtvlsZPj4PyOiUl/SE=
X-Google-Smtp-Source: APXvYqyvF35p3oYnidkKvePipaZdMRrMM301ObUbn7RxOXfOoGrNbHmh3qXRdB5jDXqbi3nufXPNpQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
	19mr3095075wmg.20.1579595008453; 
	Tue, 21 Jan 2020 00:23:28 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id p18sm2834621wmg.4.2020.01.21.00.23.27
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 21 Jan 2020 00:23:27 -0800 (PST)
Message-ID: <1b0b9e7f969425301e677ad5880b290007b8c126.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 21 Jan 2020 08:23:26 +0000
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: [PATCH] tests/fetch: Allow wget upgrade tests to run against a local server
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
X-List-Received-Date: Tue, 21 Jan 2020 08:23:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[This patch is large and the mailing list doesn't like it. It contains
a static snapshots of various websites we've been using for testing
release tarball downloads which allows us to operate independently from
the upstream through a local http server. Its in master-next if anyone
wants to look at the code, just headers posted here]

Currently these tests rely upon multiple uptream webservers which may change
or be unavailable. Add local copies of the test data, copy the httpserver
from OE-Core (used for testing there) and run these tests against a local
server instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/fetch-testdata/apple/cups/releases  | 2400 +++++++++++++++++
 .../debian/pool/main/d/db5.3/index.html       |  509 ++++
 .../downloads/enchant/1.6.0/index.html        |   15 +
 .../fetch-testdata/files/v2.8/index.html      |  774 ++++++
 .../fetch-testdata/files/v3.0/index.html      |  209 ++
 .../fetch-testdata/files/v3.1/index.html      |  156 ++
 .../fetch-testdata/files/v3.10/index.html     |  131 +
 .../fetch-testdata/files/v3.11/index.html     |  131 +
 .../fetch-testdata/files/v3.12/index.html     |  118 +
 .../fetch-testdata/files/v3.13/index.html     |  131 +
 .../fetch-testdata/files/v3.14/index.html     |  170 ++
 .../fetch-testdata/files/v3.15/index.html     |  157 ++
 .../fetch-testdata/files/v3.16/index.html     |   86 +
 .../fetch-testdata/files/v3.2/index.html      |  132 +
 .../fetch-testdata/files/v3.3/index.html      |  163 ++
 .../fetch-testdata/files/v3.4/index.html      |  127 +
 .../fetch-testdata/files/v3.5/index.html      |  111 +
 .../fetch-testdata/files/v3.6/index.html      |  159 ++
 .../fetch-testdata/files/v3.7/index.html      |   92 +
 .../fetch-testdata/files/v3.8/index.html      |  105 +
 .../fetch-testdata/files/v3.9/index.html      |  183 ++
 .../linux/utils/util-linux/v2.23/index.html   |   45 +
 .../linux/utils/util-linux/v2.24/index.html   |   43 +
 .../linux/utils/util-linux/v2.25/index.html   |   46 +
 .../linux/utils/util-linux/v2.26/index.html   |   42 +
 .../linux/utils/util-linux/v2.27/index.html   |   35 +
 .../linux/utils/util-linux/v2.28/index.html   |   42 +
 .../linux/utils/util-linux/v2.29/index.html   |   42 +
 .../linux/utils/util-linux/v2.30/index.html   |   42 +
 .../linux/utils/util-linux/v2.31/index.html   |   35 +
 .../linux/utils/util-linux/v2.32/index.html   |   35 +
 .../linux/utils/util-linux/v2.33/index.html   |   42 +
 .../linux/utils/util-linux/v2.34/index.html   |   28 +
 .../linux/utils/util-linux/v2.35/index.html   |   18 +
 .../fetch-testdata/releases/eglibc/index.html |   21 +
 .../releases/gnu-config/index.html            |    9 +
 .../releases/individual/xserver/index.html    |  609 +++++
 .../software/pulseaudio/releases/index.html   |  383 +++
 lib/bb/tests/fetch.py                         |   70 +-
 lib/bb/tests/support/httpserver.py            |   65 +
 40 files changed, 7691 insertions(+), 20 deletions(-)
 create mode 100644 lib/bb/tests/fetch-testdata/apple/cups/releases
 create mode 100644 lib/bb/tests/fetch-testdata/debian/pool/main/d/db5.3/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/downloads/enchant/1.6.0/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v2.8/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.0/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.1/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.10/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.11/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.12/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.13/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.14/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.15/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.16/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.2/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.3/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.4/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.5/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.6/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.7/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.8/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/files/v3.9/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.23/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.24/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.25/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.26/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.27/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.28/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.29/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.30/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.31/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.32/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.33/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.34/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/pub/linux/utils/util-linux/v2.35/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/releases/eglibc/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/releases/gnu-config/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/releases/individual/xserver/index.html
 create mode 100644 lib/bb/tests/fetch-testdata/software/pulseaudio/releases/index.html
 create mode 100644 lib/bb/tests/support/httpserver.py


