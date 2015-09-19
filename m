Return-Path: <raj.khem@gmail.com>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
	[209.85.213.175])
	by mail.openembedded.org (Postfix) with ESMTP id 91A3B7680E
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 19 Sep 2015 21:11:28 +0000 (UTC)
Received: by igbkq10 with SMTP id kq10so56912085igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 19 Sep 2015 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=PobWre/1rJtWEZi5GxW6E4S+D9IiwhMlZRvIwJ2z+bs=;
	b=U2BOa4Rx3H3kd6sYkMHue/0paELjxH4Td6gBAZ1VrUYassowkqKJtAaODUXUoXYTot
	u63Tm8S+0Mu3ATaU0XXSFpW+8OXAogTFj0NfLAc07aPAH35uD8E1YSoetfyHNjaB7F0t
	r1oxbtIwJKUGuIXtW1WV8AM7hIGpzeaddQ5IVMbJm3MpTlgTc5OnIMhOJOk0KR9sAKFF
	PsbyPSfJfDUsnAnjQMykQkj83CkwMfmlOXnDNELWKsQ7vb7IFsg3D0rNuYbR2iOlmC3a
	kHCpuPieqx/G3sNVyhZHzstRb0P3WpXBCWZnuV4zbzDZM1gSFb6oqLWnupFpq65UDzvQ
	IUgQ==
X-Received: by 10.50.85.20 with SMTP id d20mr4738796igz.77.1442697088582; Sat,
	19 Sep 2015 14:11:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.142.130 with HTTP; Sat, 19 Sep 2015 14:10:59 -0700 (PDT)
In-Reply-To: <CAMKF1sri5kt4-JxXDttLWOHCHmrsR6QF7MXANsU3W=08eHbUAQ@mail.gmail.com>
References: <1442594122-20623-1-git-send-email-romain.perier@gmail.com>
	<CAMKF1sri5kt4-JxXDttLWOHCHmrsR6QF7MXANsU3W=08eHbUAQ@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Sat, 19 Sep 2015 14:10:59 -0700
Message-ID: <CAMKF1srHdnf8WCvadqYL+RTJ1iQKPzOvY1kN=xcxrgxNQvKqJA@mail.gmail.com>
To: Romain Perier <romain.perier@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: bb.fetch2.git: Import errno module
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
X-List-Received-Date: Sat, 19 Sep 2015 21:11:28 -0000
Content-Type: text/plain; charset=UTF-8

On Sat, Sep 19, 2015 at 2:10 PM, Khem Raj <raj.khem@gmail.com> wrote:
> On Fri, Sep 18, 2015 at 9:35 AM, Romain Perier <romain.perier@gmail.com> wrote:
>> Currently this module is dereferencing errno.ENOENT but the python module "errno"
>> is not imported, which causes a crash when fetching from a git repository.
>>
>> Signed-off-by: Romain Perier <romain.perier@gmail.com>
>> ---
>>  bitbake/lib/bb/fetch2/git.py | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
>> index 4a32a31..9bd87ad 100644
>> --- a/bitbake/lib/bb/fetch2/git.py
>> +++ b/bitbake/lib/bb/fetch2/git.py
>> @@ -66,6 +66,7 @@ Supported SRC_URI options are:
>>  # with this program; if not, write to the Free Software Foundation, Inc.,
>>  # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>
>> +import errno
>>  import os
>>  import re
>>  import bb
>
> this patch is against poky repo, please rebase it against bitbake repo
> and resend. Its breaking all my builds currently.

This will fix my build issues like
http://errors.yoctoproject.org/Errors/Details/17879/
but it needs to be posted against bitbake repo.

