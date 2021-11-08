Return-Path: <n.papenkov@inango-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA88C433F5
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 14:16:33 +0000 (UTC)
Received: from mail.inango-systems.com (mail.inango-systems.com
 [178.238.230.57])
 by mx.groups.io with SMTP id smtpd.web10.45256.1636380991748206042
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 06:16:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@inango-systems.com
 header.s=45a440e0-d841-11e8-b985-5fcc721607e0 header.b=HPfYLGXX;
 spf=pass (domain: inango-systems.com, ip: 178.238.230.57,
 mailfrom: n.papenkov@inango-systems.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 658FA108044A;
	Mon,  8 Nov 2021 16:16:29 +0200 (IST)
Received: from mail.inango-systems.com ([127.0.0.1])
	by localhost (mail.inango-systems.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id I57EbdH9lr27; Mon,  8 Nov 2021 16:16:28 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 9D2FD1080449;
	Mon,  8 Nov 2021 16:16:28 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-systems.com 9D2FD1080449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1636380988;
	bh=EUK1PTsyv0LDA9CC2nU8GXYWs5NAtapRnvpTLOTNpCQ=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=HPfYLGXXBOvniCkDhQqWjrmAJrVVSNi3c3NNNGroD9Pa7VKrDZ9aPBMaZeiBjc69x
	 As1jjEdh/7wP1lrd1Ewb3dZxo7mpQEnjIqb0cyBaiUU36Bd4T5ofoyW6Lo3NlQzK/r
	 EBryaYJ3qDt3ZHp6CEDzgEPvTvQFaJx9Ugs4Tx7oencYD1o41nhtgFzdbjeWmnVVh1
	 czEyg+Rl03AbP75elK0Rm76M71k2rwOQzys6hMiW2FeUHvAON0+5OG4m7IN2oqi1XN
	 VU/QJT7bXqaOg9yOGw1NyAp1w85NaJVylvx7zMKCMVmSiGn1Lwu4PWtWrFI27uT8f4
	 J3SQ84Ey303YQ==
X-Virus-Scanned: amavisd-new at inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
	by localhost (mail.inango-systems.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YF27a5Wrpqkk; Mon,  8 Nov 2021 16:16:28 +0200 (IST)
Received: from mail.inango-systems.com (mail.inango-systems.com
 [172.17.220.3])
	by mail.inango-systems.com (Postfix) with ESMTP id 727D51080440;
	Mon,  8 Nov 2021 16:16:28 +0200 (IST)
Date: Mon, 8 Nov 2021 16:16:28 +0200 (IST)
From: Nikolay Papenkov <n.papenkov@inango-systems.com>
To: richard purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Dmytro Slovinskyi <d.slovinskyi@inango-systems.com>
Message-ID: 
 <2015885332.145861.1636380988162.JavaMail.zimbra@inango-systems.com>
In-Reply-To: 
 <357b3cba89e7fa3f1ba9bd300520c69e33b69f76.camel@linuxfoundation.org>
References: <20211026074217.1637-1-n.papenkov@inango-systems.com>
 <357b3cba89e7fa3f1ba9bd300520c69e33b69f76.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] bitbake: a cooker is stuck for a long
 time
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.17.220.3]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF88
 (Linux)/8.8.15_GA_4173)
Thread-Topic: bitbake: a cooker is stuck for a long time
Thread-Index: jnzHg5S7sKuUNxWa2Uatu8SsA9dz1w==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 14:16:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12943

Hello Richard,

Thanks for proposing a better solution. With this fix we don't observe cooker hang anymore and as soon as the last not-killed thread finishes parsing we see error message:
"ERROR: ParseError in None: Not all recipes parsed, parser thread killed/died? Exiting"
as expected.

Regards,
Nikolay

----- Original Message -----
From: "richard purdie" <richard.purdie@linuxfoundation.org>
To: "Nikolay Papenkov" <n.papenkov@inango-systems.com>, "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Cc: "Dmytro Slovinskyi" <d.slovinskyi@inango-systems.com>
Sent: Monday, November 8, 2021 3:32:14 PM
Subject: Re: [bitbake-devel][PATCH] bitbake: a cooker is stuck for a long time

On Tue, 2021-10-26 at 07:42 +0000, Nikolay Papenkov via lists.openembedded.org
wrote:
> From: Dmytro Slovinskyi <d.slovinskyi@inango-systems.com>
> 
> bitbake process has a deadlock in cooker.py, function parse_generator.
> The loop expects that all threads will increment self.parsed variable until it
> reaches self.toparse. When a random parse thread(s) are killed, the procedure
> is not finished and as a result self.parsed never reaches self.toparse.
> 
> The fix breaks the loop after 25 seconds of no updates in self.parsed
> number.
> 
> Signed-off-by: Dmytro Slovinskyi <d.slovinskyi@inango-systems.com>
> ---
>  bitbake/lib/bb/cooker.py | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index af794b4c42..0c07a073fa 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -2208,10 +2208,19 @@ class CookerParser(object):
>              yield not cached, mc, infos
>  
>      def parse_generator(self):
> +        current_parsed = -1
> +        no_updates_iter = 0
>          while True:
> +            if current_parsed == self.parsed:
> +                no_updates_iter += 1
> +                # Give up after 2 minutes
> +                if no_updates_iter > 480:
> +                    raise bb.parse.ParseError("No updates of parsed items for 2 minutes. Probably parsing thread was killed. Exiting.", None)
> +            else:
> +                no_updates_iter = 0
> +                current_parsed = self.parsed
>              if self.parsed >= self.toparse:
>                  break
> -
>              try:
>                  result = self.result_queue.get(timeout=0.25)
>              except queue.Empty:

Thanks for reporting this, it does explain a few strange situations we've seen
bitbake hung in and gives us something to fix.

I wasn't sure the timeout was the best way to handle this so I had a further
look at the code and I think we can use the is_alive() test to see when all
parse threads have exited. I've sent out a patch, see what you think and if that
resolves the issue you were seeing?

Cheers,

Richard




-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#12942): https://lists.openembedded.org/g/bitbake-devel/message/12942
Mute This Topic: https://lists.openembedded.org/mt/86597730/6123239
Group Owner: bitbake-devel+owner@lists.openembedded.org
Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [n.papenkov@inango-systems.com]
-=-=-=-=-=-=-=-=-=-=-=-
-- 
Nikolay Papenkov 
Architect, Arch group 


Inango. The Service Orchestrator. 
web. [ https://mail.inango.com/inango.com | inango.com ] 
mail. [ mailto:n.papenkov@inango-systems.com | n.papenkov@inango-systems.com ] 
tel. +357 99 615176 

The information contained in this message is proprietary to Inango Systems, protected from disclosure, and may be privileged. The information is intended to be conveyed only to the designated recipient(s) of the message. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, use, distribution or copying of this communication is strictly prohibited and may be unlawful. If you have received this communication in error, please notify us immediately by replying to the message and deleting it from your computer.

