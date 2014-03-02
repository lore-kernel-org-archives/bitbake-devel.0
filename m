Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 0E6CB6F508
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  2 Mar 2014 17:27:06 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s22HQotT023413; Sun, 2 Mar 2014 17:27:00 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pc-i58mc_jRh; Sun,  2 Mar 2014 17:26:59 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s22HQulv023427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 2 Mar 2014 17:26:57 GMT
Message-ID: <1393781208.22581.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Sun, 02 Mar 2014 17:26:48 +0000
In-Reply-To: <CABcZANnkVHatSbYqJAL3ZR6uKORYB=1hdBiwZOUXfCad4S2T8w@mail.gmail.com>
References: <1393608174.31769.199.camel@ted>
	<CABcZANnkVHatSbYqJAL3ZR6uKORYB=1hdBiwZOUXfCad4S2T8w@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/git: Separate out an ls-remote function
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
X-List-Received-Date: Sun, 02 Mar 2014 17:27:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2014-03-01 at 21:50 -0700, Chris Larson wrote:
> 
> On Fri, Feb 28, 2014 at 10:22 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         -    def _latest_revision(self, ud, d, name):
>         +    def __lsremote(self, ud, d, search):
> 
> 
> Are we sure we want to use __ here? Double-underscore will trigger
> python internal name mangling. While using it doesn't break anything,
> it doesn't really buy us much either vs _, and makes inspection of the
> class/object rather ugly, IMO :)
> 
Agreed, I changed it before merging.

Cheers,

Richard



