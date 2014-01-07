Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id EB7306C73F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 13:19:00 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s07DIsNo002510; Tue, 7 Jan 2014 13:18:55 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jDO2-LAAdJED; Tue,  7 Jan 2014 13:18:54 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s07DIoTW002439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jan 2014 13:18:52 GMT
Message-ID: <1389100725.6899.21.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Tue, 07 Jan 2014 13:18:45 +0000
In-Reply-To: <4d61da4f684bc292dd35b407c2dfa9ce5e6633c4.1389005562.git.liezhi.yang@windriver.com>
References: <cover.1389005562.git.liezhi.yang@windriver.com>
	<4d61da4f684bc292dd35b407c2dfa9ce5e6633c4.1389005562.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/1] bitbake/cooker.py: set the PREFERRED_VERSION from command line
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
X-List-Received-Date: Tue, 07 Jan 2014 13:19:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-01-06 at 18:53 +0800, Robert Yang wrote:
> We can't set the PREFERRED_VERSION from the command line, this will make
> it possible:
> 
> $ P_V="3.81" bitbake make
> $ P_V="3.81" bitbake make-native
> 
> Then the make-3.81 and make-native-3.81 will be built (the default is
> 3.82)
> 
> Another we that we have originally thought was:
> 
> $ export BB_PRESERVE_ENV=1
> $ PREFERRED_VERSION_make = 3.81 bitbake make
> 
> This worked for make, but didn't work for make-native since
> we can't use "-" in a shell environment variable.
> 
> TODO:
> * This is just a RFC and open for discussion, any comments is
>   appreciated.
> 
> * It only can set the PREFERRED_VERSION for the pkg_to_build, we can
>   make it more flexible, for example, if we found the keyword
>   PREFERRED_VERSION in the P_V, we can set it for any recipe:
>   (assume core-image-sato RDEPENDS on make)
>   $ P_V="PREFERRED_VERSION_make=3.81" bitbake core-image-sato

Well, this defines a different version of PREFERRED_VERSION with
completely different semantics to the other one. I don't think this is
acceptable or a good way to avoid this problem and will ultimately just
confuse more users.

> * BTW, another questions, can we change the PREFERRED_VERSION to P_V
>   or PF_V, and the PREFERRED_PROVIDER to P_P ot PF_P, please ? They are
>   a little long to type and easy to make typos currently.

No, this would be extremely confusing with PV and other variables.
Please use copy and paste or something ;-).

A better way of handling things might be to translate "__" to "-" when
importing variables from the environment so you could set:

PREFERRED_VERSION_make__native = "3.81"

I'm open to other ideas but don't like P_V at all, particularly when it
behaves differently to PREFERRED_VERSION.

Cheers,

Richard




