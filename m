Received: from mail-qa0-f54.google.com ([209.85.216.54])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SFDFP-0006Tv-OG
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 01:34:47 +0200
Received: by qao25 with SMTP id 25so180qao.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Apr 2012 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=Bty6VPjbrJ9q7m4pBNjAUKRCfSaz6wx1Z5gk5xgmrqk=;
	b=yDCNGCNaa7FAhz6pSLNqr4igcEarkKFQvJEXbwPgnXm/++/TKgTJm8jF7Svq0/UKaY
	rfxLCbVWdaTvQO9xbMM0OPpo6LuTwalBMF1A8fi1cNgxw4ZB7vOE8pI+0XrOjiLAhEbl
	5YkrKkNvnOGFWhfzFRYmaI2zHzjPzetZts7kQfehM03DmGrtVHggbb7ha+FWLcJuDgl4
	mcM5Jm6usigE5ZXPBC6pJFe3YUIdUnsRkIwM/q82rU1xZDsbB0t80/+MTlgiHTWSIJAh
	1hhlErZdMQPeYJLxw7IAYinCZvfO1tnHIJGawKOTT58ZbvPNio51zgq+NbIlG47muFbh
	OUEQ==
Received: by 10.224.116.74 with SMTP id l10mr19595891qaq.42.1333495537678;
	Tue, 03 Apr 2012 16:25:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.24.196 with HTTP; Tue, 3 Apr 2012 16:25:17 -0700 (PDT)
In-Reply-To: <1333495429-17048-1-git-send-email-kergoth@gmail.com>
References: <1333495429-17048-1-git-send-email-kergoth@gmail.com>
From: Chris Larson <kergoth@gmail.com>
Date: Tue, 3 Apr 2012 16:25:17 -0700
Message-ID: <CABcZANnJnPvg13jV8LfSCPooQFh9CGyu+W=iRWRT_CQ43BuUdA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH] Remove whitelisted vars from non-task deps
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 03 Apr 2012 23:34:47 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Apr 3, 2012 at 4:23 PM, Christopher Larson <kergoth@gmail.com> wrote:
> This is only really a potential issue for variables from the environment, as
> it's the existance/removal of the variable that's an issue, not its value, and
> the other whitelisted variables are set in our metadata. This which means in

Erm, s/This which/This/
-- 
Christopher Larson


