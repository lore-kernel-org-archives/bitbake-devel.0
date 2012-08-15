Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1T1h5L-0003jD-Qn
	for bitbake-devel@lists.openembedded.org;
	Wed, 15 Aug 2012 19:08:48 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q7FGum9u012025
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 15 Aug 2012 09:56:48 -0700 (PDT)
Received: from [172.25.32.41] (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 15 Aug 2012 09:56:48 -0700
Message-ID: <502BD4CE.3000102@windriver.com>
Date: Wed, 15 Aug 2012 11:56:46 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:13.0) Gecko/20120615 Thunderbird/13.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1345049422.14667.11.camel@ted>
In-Reply-To: <1345049422.14667.11.camel@ted>
X-Enigmail-Version: 1.4.3
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] knotty: Fold knotty2 into knotty and make it the default
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
X-List-Received-Date: Wed, 15 Aug 2012 17:08:48 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 08/15/2012 11:50 AM, Richard Purdie wrote:
> There is no good reason knotty2 shouldn't be the default now. If you need
> the old behaviour, just pipe the output through cat as non-interactive
> terminals get the old output.


I didn't look at this in much detail to see if it is was a direct fold or if you made changes along the way.

I have a whole series of patches outstanding against knotty2 for fixing its behavior for the very annoying line wrapping problems and the like.  Certainly I can rebase the work done to this end, but these problems need to be addressed, preferably before you make this the default.

Jason.



