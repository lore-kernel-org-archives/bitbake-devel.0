Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SmaJS-0006Xp-EI
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Jul 2012 02:52:54 +0200
Received: by lbol5 with SMTP id l5so10594344lbo.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Jul 2012 17:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=x8ZNQvTLg0W9VTNUXZbbHyD1bbxNoYbfED4mzYbqVdM=;
	b=cRDed9Du8+7Qhasrh5raIVw3WAZXT+msbO1ynmzhX+UiSOx7hLfy8Ev0KxUjw5EXFn
	Z8HPsWRPZmcl+hU66F7ppPWh1Pgh4XTvDlBQG0QncslUzPvJ6iZubzndtGp+GlNJXebY
	u7bxyB6zkMzaTM/XgIDfSCXCtoKGDITHnmb1rDazsYjI62IEBun6T7tg54xBa1mITutX
	luYQBg1ys0c6SVjAE8oEmxcGsJ3U3ryVCTuszrbaYoUCpeiiOykJnNgD4BzcC0Ubp598
	IJ5MIlaZnw3SoXEWMGtQGj6OpgP/dpqdLxXbjn00JA7LzaeuuIWP1prkT1ivNvzaobAf
	JbeQ==
Received: by 10.152.105.51 with SMTP id gj19mr23705117lab.38.1341448910586;
	Wed, 04 Jul 2012 17:41:50 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.64.180 with HTTP; Wed, 4 Jul 2012 17:41:30 -0700 (PDT)
In-Reply-To: <CAGrhNMxsvb7Qbcg369748pQi8S3+tO56pNTSr4urQTrH1M23QA@mail.gmail.com>
References: <CAGrhNMxsvb7Qbcg369748pQi8S3+tO56pNTSr4urQTrH1M23QA@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 4 Jul 2012 17:41:30 -0700
X-Google-Sender-Auth: UfdFEL6o0xeuKOOGb4JY0ilqBYU
Message-ID: <CABcZANnbVf-d=2gZK1cbSR6y3JWAaHgXjszjA2qbo8jYVmuZgA@mail.gmail.com>
To: Felipe Tonello <eu@felipetonello.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Updating optparse module to argparse module
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
X-List-Received-Date: Thu, 05 Jul 2012 00:52:54 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 4, 2012 at 4:12 PM, Felipe Tonello <eu@felipetonello.com> wrote:
> It's my first time here. So just to make a short intro, my name is Felipe
> Ferreri Tonello, I'm from Brazil but I currently live in USA.
>
> This patch is just to update the command line parse module to fit the new
> Python standards.

Sorry, that won't do, just yet. Last I checked, the current required
python version for bitbake and the main users of it is 2.6, not 2.7.
-- 
Christopher Larson


