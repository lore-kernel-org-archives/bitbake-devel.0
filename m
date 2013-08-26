Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 19EAF6B587
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Aug 2013 15:12:49 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7QFOlNZ009027; Mon, 26 Aug 2013 16:25:01 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DCjuVx2VSZ7A; Mon, 26 Aug 2013 16:25:01 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7QFOvKM009078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 26 Aug 2013 16:24:58 +0100
Message-ID: <1377529955.26773.73.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Mon, 26 Aug 2013 16:12:35 +0100
In-Reply-To: <CABcZAN=pe52=h7NUyBWCE3s2Eu47fbuBwzpAaCdgaY+nmu_v0w@mail.gmail.com>
References: <1377356035.6762.193.camel@ted>
	<CABcZAN=pe52=h7NUyBWCE3s2Eu47fbuBwzpAaCdgaY+nmu_v0w@mail.gmail.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH v2] data_smart: Add _remove operator
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
X-List-Received-Date: Mon, 26 Aug 2013 15:12:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-08-26 at 07:54 -0700, Chris Larson wrote:

> On Sat, Aug 24, 2013 at 7:53 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         @@ -583,6 +588,14 @@ class DataSmart(MutableMapping):
>                          value = copy.copy(local_var["defaultval"])
>                  if expand and value:
>                      value = self.expand(value, None)
>         +        if value and flag == "_content" and local_var and
>         "_removeactive" in local_var:
>         +            for i in local_var["_removeactive"]:
>         +                if " " + i + " " in value:
>         +                    value = value.replace(" " + i + " ", " ")
>         +                if value.startswith(i + " "):
>         +                    value = value[len(i + " "):]
>         +                if value.endswith(" " + i):
>         +                    value = value[:-len(" " + i)]
>
> I'm curious, did you profile this implementation vs a
> split-filter-rejoin?

No, in retrospect, that might have been better. I'll take a patch to
update it :)

Cheers,

Richard




