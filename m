Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3EDAB65CBA
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Sep 2016 21:46:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u82LjMtZ002508; Fri, 2 Sep 2016 22:46:40 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id deEQxZRg7w0M; Fri,  2 Sep 2016 22:46:40 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u82LkYa8002578
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 2 Sep 2016 22:46:35 +0100
Message-ID: <1472852794.29583.182.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Evade Flow <evadeflow@gmail.com>
Date: Fri, 02 Sep 2016 22:46:34 +0100
In-Reply-To: <CAMAb8ZP-oC0Pqgh22KjFk2Py1atsFCP-1KqaKod8XsdN9s0k9w@mail.gmail.com>
References: <CAMAb8ZNGCbyo+49tXBPZJy-jvSbwgShfbFjZ18OU4kARRLqVNw@mail.gmail.com>
	<1472817465.29583.164.camel@linuxfoundation.org>
	<CAMAb8ZP-oC0Pqgh22KjFk2Py1atsFCP-1KqaKod8XsdN9s0k9w@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Conditionally inherit own-mirrors and set SOURCE_MIRROR_URL?
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
X-List-Received-Date: Fri, 02 Sep 2016 21:46:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2016-09-02 at 15:26 -0400, Evade Flow wrote:
> > You could do something like:
> ...
> > 
> SOURCE_MIRROR_URL ?= "{@base_contains('LOCALBUILD', 'local', '
> file://xxx', 'http://xxx', d)}"
> 
> 
> That's exactly what I was looking for, thanks. I gather I can't put
> functions in local.conf, which is where our current build is setting
> SOURCE_MIRROR_URL. Can I trouble you to recommend a home for such a
> function? It 'feels weird' to put it in a recipe, is there some
> other, semi-standard place to stuff helper functions?

It is an annoying and somewhat artificial limitation. I have been known
to work around it by adding a xxx.bbclass file in a classes directory
and then INHERIT += "xxx".

Cheers,

Richard

