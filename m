Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com
	[209.85.214.41])
	by mail.openembedded.org (Postfix) with ESMTP id 2BFD171ADD
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Jan 2017 11:03:24 +0000 (UTC)
Received: by mail-it0-f41.google.com with SMTP id c7so17812360itd.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Jan 2017 03:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=hvA5Rf+4yOO8WIB1ZlXbye9AtRUSDC0BWFoQ9mog+bo=;
	b=kpY+BhbKQvNTj8oHWIxpbk0ljnw45M/w2KXB3KHLZ/MdQICOhQ7K66wvZ6+y6Jj7da
	WP/nUsvbhgQ2+kapK+8OEHTZG9clb+I59ykqBr0nIKCBNX+/MJ2l3p2pkGpmBSX8oShP
	lmKJG19hOdwP13Vfdh4K0GL8QZhmPK8IDWAnTKLiK614RX0r0zvbvye+kYJHAVYsdmFD
	QWHuaI8O3wBFF0mh9rLP7znR5NdV2I51UxfeHf5mF/lscWcStVYRj/tO2ykZLAOauYH8
	mYOfHLs/pdINO250W1rD70PkdWNR+LYkzSGnBAQzyT36DvJk50ZMFw5rNro8L+TnSpTz
	bTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=hvA5Rf+4yOO8WIB1ZlXbye9AtRUSDC0BWFoQ9mog+bo=;
	b=a0vxUlkX5z+XrUzaC/A2/ISQOsX7Hf3sAv5xsJQXu638DJ2CB0bB9jNywy3GoCVZXB
	wYlh8j66CYqSvBPFkTzljppIs3h5hWK/ZXNxS0XOYl91N4LPnRmm3m7uFze63PKmKm5F
	rct3ByZBB69/q09G6WETs0C0djYuJbqSEhmay5ZEjCykzFZZoUSoJfboYL1SqWxPaIoS
	Mba98Ql1LgcwtNHKMHaK+6tcFNqgPzwvXV5pe/8f83l36D4EqXEmr4tWjVTsyAwqMcOZ
	yALLIsBOaUoTEV1M3cdWwteG+qNcbfPvCOJKZSPDmHTkN3ygPzIXqsAhks3dRthcuTcw
	SDkg==
X-Gm-Message-State: AIkVDXIA6gYucUjy8PHZU75krQf9Lnyy2gi8tp862TQVdGEYGNTB38BhRK1pUdncZRI1as3D
X-Received: by 10.36.161.70 with SMTP id n6mr4483378iti.76.1483959804990;
	Mon, 09 Jan 2017 03:03:24 -0800 (PST)
Received: from pohly-mobl1 (p5DE8F553.dip0.t-ipconnect.de. [93.232.245.83])
	by smtp.gmail.com with ESMTPSA id
	k205sm6139719ita.15.2017.01.09.03.03.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Jan 2017 03:03:23 -0800 (PST)
Message-ID: <1483959801.2137.33.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 09 Jan 2017 12:03:21 +0100
In-Reply-To: <88c860131b153f5b95efb08c219d4dc5f0712f8b.1483696010.git.patrick.ohly@intel.com>
References: <cover.1483696010.git.patrick.ohly@intel.com>
	<88c860131b153f5b95efb08c219d4dc5f0712f8b.1483696010.git.patrick.ohly@intel.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: Richard Purdie <richard.purdie@intel.com>
Subject: Re: [PATCH 1/3] recipes: anonymous functions with priorities
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
X-List-Received-Date: Mon, 09 Jan 2017 11:03:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2017-01-06 at 10:50 +0100, Patrick Ohly wrote:
> The default priority is 100. Functions with higher values run later.
> 
> For example, rm_work.bbclass can use this to ensure that it runs
> later than other anonymous functions:
> 
> python __anonymous_rm_work() {
>     bb.build.addtask(....)
> }
> __anonymous_rm_work[priority] = "1000"

We discussed this a bit on chat, and there were concerns that priorities
are not defined well enough and will cause maintenance problems. Let me
add here that this was partly intentional: bitbake doesn't need to care
about specific priorities, that's something that the users of bitbake
(like OE-core) need to define. Admittedly my OE-core patch set did not
address that either, although it could be added with a documentation
patch.

As alternative, Richard suggested to add more events that will emit at
well-defined points in the processing of a recipe. However, as he said
himself, that then leads to the problem of ordering event handlers once
there is more then one handler who wants to run for a certain event.
IMHO that just reduces the scope of the problem, but does not really
solve it.

Basically, there would have to be a dedicated event for use only by
rm_work and nothing else, which kind of breaks the separation between
bitbake mechanisms and their use in meta data. Each time meta data needs
a new separate "slot", bitbake would have to be extended, which isn't
the case with the priority approach where each priority value already is
a separate slot.

Having said that, I don't have any strong opinion about this, I just
wanted to share some more thoughts on this.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




