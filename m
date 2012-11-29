Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Te4Av-000056-8q for bitbake-devel@lists.openembedded.org;
	Thu, 29 Nov 2012 14:29:09 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qATDEnm5020701;
	Thu, 29 Nov 2012 13:14:49 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23319-08; Thu, 29 Nov 2012 13:14:45 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qATDEddg020694
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2012 13:14:41 GMT
Message-ID: <1354191677.4053.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANkDfxxQCupuJLEjJJfXM44MczWcSpvZCqQKmOsDbCPF5A@mail.gmail.com>
References: <1354134376.15992.5.camel@ted>
	<CABcZANkV1td28s-vZCXfukMHvYUAkoUH=3jScF3ZVkaBTyp9Qw@mail.gmail.com>
	<CABcZANkDfxxQCupuJLEjJJfXM44MczWcSpvZCqQKmOsDbCPF5A@mail.gmail.com>
Date: Thu, 29 Nov 2012 12:21:17 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.2.3-0ubuntu6 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, "Eggleton,
	Paul" <paul.eggleton@intel.com>
Subject: Re: [PATCH] build.py: Preserve sigdata files in the stamps directory
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
X-List-Received-Date: Thu, 29 Nov 2012 13:29:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-11-28 at 15:19 -0700, Chris Larson wrote:
> On Wed, Nov 28, 2012 at 3:19 PM, Chris Larson <clarson@kergoth.com>
> wrote:
>         On Wed, Nov 28, 2012 at 1:26 PM, Richard Purdie
>         <richard.purdie@linuxfoundation.org> wrote:
>                 -        bb.utils.remove(mask)
>                 -
>                 +        # Preserve sigdata files in the stamps
>                 directory
>                 +        for name in glob.glob(mask):
>                 +            if name.find("sigdata") != -1:
>
>         if 'sigdata' not in name:
>
> Erm, s/not in/in/. You get the idea. Use of 'find' only really makes
> sense if you need the locations within the string.

Yes, good point, thanks.

Richard




