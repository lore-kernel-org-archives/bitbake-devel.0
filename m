Return-Path: <bela@becker.rocks>
Received: from becker.rocks (catv-188-142-200-211.catv.broadband.hu
	[188.142.200.211])
	by mail.openembedded.org (Postfix) with ESMTP id EE61874C87
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2018 14:40:56 +0000 (UTC)
Received: from maxion.localnet (catv-89-133-30-81.catv.broadband.hu
	[89.133.30.81]) by becker.rocks (Postfix) with ESMTPSA id C0179E01D8;
	Tue, 15 May 2018 16:40:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=becker.rocks; s=mail;
	t=1526395256; bh=gDrfFutCzVxoVD+VsuqqNPlz8JghO1vkZrzMzCELMI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3Jlj0C9aRhTIOnD+3qUXNUkCIKW6jCKAcYHg+uYyUG+CGzcdtK5gFm58Lfu9rTUv
	NEQt38hDr1vSHJa4SoXxKmLx8jYae12N4rATa501wc9xamDuDr++2oxrPNr/pvPw/4
	JSgqh8v1ke3odODPnu2vKq8UG+r1qZZl7AAApe0Q=
From: Becker =?ISO-8859-1?Q?B=E9la?= <bela@becker.rocks>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 15 May 2018 16:40:56 +0200
Message-ID: <1549223.76D6mBYNsj@maxion>
In-Reply-To: <CAHb6uwd5ugu+pARsTcMVtyjf_UrCthqnG0Pbt0Obc4evSfbWQw@mail.gmail.com>
References: <CAHb6uwd5ugu+pARsTcMVtyjf_UrCthqnG0Pbt0Obc4evSfbWQw@mail.gmail.com>
MIME-Version: 1.0
Cc: Tim Godfrey <timothy.godfrey@gmail.com>
Subject: Re: bitbake task not returning
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
X-List-Received-Date: Tue, 15 May 2018 14:40:57 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

This looks like an interactive script that reads its parameters from the terminal. As such it will not work well inside an automated build environment.
Check its docs if you can supply the information on the command line, so that it can run non-interactively. If that isn't possible, read into the script and rewrite it so it does not need any input.



