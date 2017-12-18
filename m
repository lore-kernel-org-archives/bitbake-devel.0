Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5105171BF0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Dec 2017 15:08:06 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	vBIF86UE009895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Mon, 18 Dec 2017 15:08:07 GMT
Message-ID: <1513609686.16507.44.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: David Reyna <david.reyna@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Mon, 18 Dec 2017 15:08:06 +0000
In-Reply-To: <e0d2ed2f79a7c475fccd2f4f788e8feccd2156bc.1512030424.git.David.Reyna@windriver.com>
References: <cover.1512030424.git.David.Reyna@windriver.com>
	<e0d2ed2f79a7c475fccd2f4f788e8feccd2156bc.1512030424.git.David.Reyna@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH V2 2/6] toaster: update Toaster for Django 1.11
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
X-List-Received-Date: Mon, 18 Dec 2017 15:08:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-11-30 at 00:55 -0800, David Reyna wrote:
> --- a/lib/toaster/toastergui/views.py
> +++ b/lib/toaster/toastergui/views.py
> @@ -277,7 +277,7 @@ def _validate_input(field_input, model):
>              return None, invalid + str(field_input_list)
>  
>          V2 # Check we are looking for a valid field
> -        valid_fields = model._meta.get_all_field_names()
> +        valid_fields = [f.name for f in model._meta.get_fields()]
>          for field in field_input_list[0].split(AND_VALUE_SEPARATOR):
>              if True in [field.startswith(x) for x in valid_fields]:
>                  break

Sorry about the delay with these. Somehow there is a "V2" in the patch
that caused it to fail to apply. I've fixed that up manually and
applied it.

Cheers,

Richard

