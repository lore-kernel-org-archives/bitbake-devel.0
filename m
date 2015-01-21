Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8FF4E65C7B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 13:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LDt1x0025724; Wed, 21 Jan 2015 13:55:01 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PCiaeJ2f5ToM; Wed, 21 Jan 2015 13:55:01 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LDsmip025720
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Jan 2015 13:55:00 GMT
Message-ID: <1421848488.1798.55.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chong Lu <Chong.Lu@windriver.com>
Date: Wed, 21 Jan 2015 13:54:48 +0000
In-Reply-To: <dcc1cd29cdf4dbcf242fda70bbd03fe9a2e84263.1421657244.git.Chong.Lu@windriver.com>
References: <cover.1421657244.git.Chong.Lu@windriver.com>
	<dcc1cd29cdf4dbcf242fda70bbd03fe9a2e84263.1421657244.git.Chong.Lu@windriver.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: prserv/serv: sync database after thead quit
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
X-List-Received-Date: Wed, 21 Jan 2015 13:55:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-01-19 at 16:48 +0800, Chong Lu wrote:
> We need sync database after thread quit, else we may get a empty table
> after import a PR database.
> 
> [YOCTO #6752]
> 
> Signed-off-by: Chong Lu <Chong.Lu@windriver.com>
> ---
>  bitbake/lib/prserv/serv.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
> index 25eb46a..c774c5e 100644
> --- a/bitbake/lib/prserv/serv.py
> +++ b/bitbake/lib/prserv/serv.py
> @@ -87,7 +87,7 @@ class PRServer(SimpleXMLRPCServer):
>                  self.finish_request(request, client_address)
>                  self.shutdown_request(request)
>                  iter_count = (iter_count + 1) % iterations_between_sync
> -                if iter_count == 0:
> +                if iter_count == 0 or self.quit:
>                      self.table.sync_if_dirty()
>              except:
>                  self.handle_error(request, client_address)

Thanks for the patch. I had a look at this problem and I think there are
bigger problems with the code. Can you take a look at the patch I've
just posted, it should solve this issue as well as several others.

Cheers,

Richard


