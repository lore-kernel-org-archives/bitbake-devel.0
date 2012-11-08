Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TWT3P-00014J-Nx
	for bitbake-devel@lists.openembedded.org;
	Thu, 08 Nov 2012 15:25:59 +0100
Received: by mail-lb0-f175.google.com with SMTP id j7so135296lbo.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 Nov 2012 06:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=ST/n99rYv0FOF82NBOdPHKu0GcVnWVsWrxy7jBxXk3s=;
	b=UST6iCMaJXLf0i4bk6mtTAPdFgcJbXo8ilHIz8Qdkm+Ld1uz5I+alPwgC+8zU0VogI
	b3/Yi+EkqlyEUQ9QCsLRf5Z0hK/8KB6e1bI97Cd6XJ8RXG51ucZ2wYSzYEMVg6krdum3
	+QIgVBnJIc0QQnf5VmE2PwsP0wzPiQZyBvdlkQF0+JHM/QBFcU4jGkNVbE9xNVM0PgOs
	Xv1RocBiGVccix+7xhOtBqDxKOl33uwfhtBkuJH7LjLq06moeiB4wo4hNVIyL1eayJDQ
	nPA9g2m7ziN6AHx0HZq10ubFY8lpSQdOwViMGBl0ajz7RTlP4Kcq6Biwb2OM3k0GO/zX
	KJIw==
Received: by 10.152.108.42 with SMTP id hh10mr7623092lab.4.1352383932163; Thu,
	08 Nov 2012 06:12:12 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.1.49 with HTTP; Thu, 8 Nov 2012 06:11:52 -0800 (PST)
In-Reply-To: <1352379822-1505-1-git-send-email-cristiana.voicu@intel.com>
References: <1352379822-1505-1-git-send-email-cristiana.voicu@intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 8 Nov 2012 07:11:52 -0700
X-Google-Sender-Auth: shlgrDDIc0KteIGekB9zB1OS1GI
Message-ID: <CABcZANmhcXGWk3e0tvQzKNgSCxErPbaAVsNs_UR3r1QF+g3MKg@mail.gmail.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: hob was freezing because it doesn't receives well the log file
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
X-List-Received-Date: Thu, 08 Nov 2012 14:25:59 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 8, 2012 at 6:03 AM, Cristiana Voicu
<cristiana.voicu@intel.com> wrote:
> -after pressing "build image" button, hob was freezing because it didn't
> receive well the log file
>
> [YOCTO #3398]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> index 5026bf7..4b908f9 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -420,7 +420,7 @@ class HobHandler(gobject.GObject):
>          self.build.reset()
>
>      def get_logfile(self):
> -        return self.server.runCommand(["getVariable", "BB_CONSOLELOG"])
> +        return self.server.runCommand(["getVariable", "BB_CONSOLELOG"])[0]

Oops, sorry about this. I thought I fixed all the runCommand calls,
but must have missed one.
-- 
Christopher Larson


