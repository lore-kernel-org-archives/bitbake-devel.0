Return-Path: <i.efimov@inango-systems.com>
Received: from mail.inango-sw.com (mail.inango-systems.com [213.136.71.184])
	by mail.openembedded.org (Postfix) with ESMTP id C97AA7F642
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2019 06:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-sw.com (Postfix) with ESMTP id F37E37A12CA;
	Thu,  7 Nov 2019 08:35:22 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
	by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id GT_wygIKMBhr; Thu,  7 Nov 2019 08:35:14 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-sw.com (Postfix) with ESMTP id 5E10C7A237D;
	Thu,  7 Nov 2019 08:35:14 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com 5E10C7A237D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1573108514;
	bh=u9Ag4MFJKUST039bIElQK+FSz2UkiuhkBumx42ockOw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=W7G3OXSdw/n1bMDsKjVoRDAQxwkncUW6kqo77FoKYp9CBLUe5k7IDV3yC/eQbq/yN
	IGtJVZqKwuqyuirp27tGZn7MPiJVnIIIEhnyvFcVysI113+jqEcr08x5rRaca+kmiF
	dfH3wGGPnoVsY4PVKF3UgYqVX68ULWoxD9H3ISbQ/WtKVGDrWASTCTweoCoaZpaeeJ
	kk8VYIfoXSO56Ru9NlWERixc+k+iKAuKtEi3TaCzYqoGP7Sf8oNkrvtTynOpUVnDSd
	Jr/vneIMiLMhTbBQsfst35+8c5m1Xz1F8fcOq+BWoWMzzy62XePx2ungY0XL7pkIHE
	WaWAV+u9MfVxw==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
	by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wUW23WiHQZnN; Thu,  7 Nov 2019 08:35:14 +0200 (IST)
Received: from mail.inango-sw.com (mail.inango-sw.com [172.17.220.3])
	by mail.inango-sw.com (Postfix) with ESMTP id 182887A12CA;
	Thu,  7 Nov 2019 08:35:14 +0200 (IST)
Date: Thu, 7 Nov 2019 08:35:12 +0200 (IST)
From: Ivan Efimov <i.efimov@inango-systems.com>
To: akuster <akuster@mvista.com>
Message-ID: <1370792230.5885.1573108512017.JavaMail.zimbra@inango-systems.com>
In-Reply-To: <c080c0f1-426e-e40a-c4f5-3e66c6f7fd86@mvista.com>
References: <20191105140735.8204-1-i.efimov@inango-systems.com>
	<c080c0f1-426e-e40a-c4f5-3e66c6f7fd86@mvista.com>
MIME-Version: 1.0
X-Originating-IP: [172.17.220.3]
X-Mailer: Zimbra 8.8.9_GA_3006 (ZimbraWebClient - GC78 (Linux)/8.8.9_GA_3006)
Thread-Topic: bitbake-worker child process create group before registering
	SIGTERM handler
Thread-Index: rcKYbhrf4PiRdzQ7b9c8aPf9hakMqA==
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [1.32][PATCH] bitbake-worker child process create group before registering SIGTERM handler
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
X-List-Received-Date: Thu, 07 Nov 2019 06:35:24 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Armin,

I've rechecked that this issue is relevant to next branches besides 1.32 and master:

1.26
1.28
1.30
1.34
1.36
1.38
1.40
1.42
1.44

Could you please tell me what of them are still supported by BitBake community?

Best regards,
Ivan



[ https://inango.com/ |    ] 
Ivan Efimov 
Software Architect, Arch Group 
i.efimov@inango-systems.com 
T +7 343 298 0147 C +7 904 9 888 350 
[ https://inango.com/ | inango.com ] [ https://www.linkedin.com/company/inango ]

----- Original Message -----
From: "akuster" <akuster@mvista.com>
To: "Ivan Efimov" <i.efimov@inango-systems.com>, bitbake-devel@lists.openembedded.org
Sent: Thursday, November 7, 2019 3:00:46 AM
Subject: Re: [bitbake-devel] [1.32][PATCH] bitbake-worker child process create group before registering SIGTERM handler

On 11/5/19 6:07 AM, Ivan Efimov via bitbake-devel wrote:
> The bitbake-worker child on the SIGTERM signal handling send the SIGTERM to all
> processes in it's process group. In cases when the bitbake-worker child got
> SIGTERM after registering own SIGTERM handler and before the os.setsid() call
> it can send SIGTERM to unwanted processes.
>
> In the worst case during SIGTERM processing the bitbake-worker child can be in
> the group of the process that started BitBake itself. As a result it can kill
> processes that not related to BitBake at all.
>
> Signed-off-by: Ivan Efimov <i.efimov@inango-systems.com>

I see master and 1.32 have patches. To confirm, 1.44, 140.1.38, 1.36,...
need this too?

- Armin
> ---
>  bin/bitbake-worker | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index db3c4b18..6a12a31c 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -189,9 +189,6 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
>              global worker_pipe_lock
>              pipein.close()
>  
> -            signal.signal(signal.SIGTERM, sigterm_handler)
> -            # Let SIGHUP exit as SIGTERM
> -            signal.signal(signal.SIGHUP, sigterm_handler)
>              bb.utils.signal_on_parent_exit("SIGTERM")
>  
>              # Save out the PID so that the event can include it the
> @@ -206,6 +203,11 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
>              # This ensures signals sent to the controlling terminal like Ctrl+C
>              # don't stop the child processes.
>              os.setsid()
> +
> +            signal.signal(signal.SIGTERM, sigterm_handler)
> +            # Let SIGHUP exit as SIGTERM
> +            signal.signal(signal.SIGHUP, sigterm_handler)
> +
>              # No stdin
>              newsi = os.open(os.devnull, os.O_RDWR)
>              os.dup2(newsi, sys.stdin.fileno())

