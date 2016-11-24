Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id E475671AC5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 09:44:38 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id x94so70530144ioi.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 01:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:date:in-reply-to:references:organization
	:mime-version:content-transfer-encoding;
	bh=nQsRMSfoc/iLxgt5o/HYyXIwlBhTtRZDmHEtrhLUs58=;
	b=ONvHClUFWRwqe5B6reNXhri+DDy/9wvxzD2NlSJqj5/eO4gM4qZ6ZX2XA37JCqUWCm
	ZZrFDVqj74eAQWHM1QVENc90kqEMgQleitcSs+InI1ok1FANcJ7QYUrjbkhr/oudhsy8
	1YZo1qg7KdbzVYrL7OLR03HbQRfj1Q75QDkVTJljOswxwEuYMvHpIZXzLyayqpg4xGq7
	0XqomuW1VIIKJRxOC+zu+lBJUzKkeRe3397GMJg3nCw7MD/Es3zuTLjIcyaT21TBm6cu
	igc8GR20oxQI8wOhPStJxuMDZN3OY6CjO/H52cyc07qmwVvSs+/MSk5sNbpmJizF7r1g
	uCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=nQsRMSfoc/iLxgt5o/HYyXIwlBhTtRZDmHEtrhLUs58=;
	b=DbhaBv4sgxz6qnmJw7HafM7Tl59/8fq5eZYu5SqI7pmgfTwqDhgHlqOWnHzs1EkV2D
	NmxJ4psPxkj4GS/c01OYEclu8dj+FgYcIPENYWS5Xh9lReDNZCfMS0cOxXTDce677HEs
	W6mbzkP1RjdKovnta5fwcUaAbF9ko4+sINZXl5DSddL+QUW7pDUcg+bfBBuMW1EJ7o7W
	MOzceF3Azbnam0pZosthGUFC/0WHapBYet6fQDZ5OlYp578JkKYW/JgUFZWQfyAGp57q
	HjjPkK2psJ9otxUz5qEGkXlWUY76b6LzxkUlfJKMifTNpHJAYHR0o6iKJ0+R2QyoiFzw
	lfmw==
X-Gm-Message-State: AKaTC03TknDcRa+1vOVo5kEQq2d9PL4QsZk+vsO6zu7DY6s+SgcdLvEHTLGDiymrxjPvVJ4p
X-Received: by 10.36.203.66 with SMTP id u63mr1293606itg.111.1479980679155;
	Thu, 24 Nov 2016 01:44:39 -0800 (PST)
Received: from pohly-mobl1 (p5DE8D6D7.dip0.t-ipconnect.de. [93.232.214.215])
	by smtp.gmail.com with ESMTPSA id
	y125sm2462435ity.13.2016.11.24.01.44.37
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 24 Nov 2016 01:44:37 -0800 (PST)
Message-ID: <1479980675.6873.26.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 10:44:35 +0100
In-Reply-To: <1479972055-1998-1-git-send-email-patrick.ohly@intel.com>
References: <1479972055-1998-1-git-send-email-patrick.ohly@intel.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Subject: Re: [PATCH] pseudo: include fix for xattr corruption
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
X-List-Received-Date: Thu, 24 Nov 2016 09:44:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-11-24 at 08:20 +0100, Patrick Ohly wrote:
> pseudo_1.8.1.bb gets the backported patch and pseudo_git.bb gets
> updated to include the commit, which currently is the most recent
> commit on the pseudo master branch.

Please ignore, wrong list. I'll resend.
-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




