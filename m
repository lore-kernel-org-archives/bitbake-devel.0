Received: from linuxplesk15.openhost.net.nz (linuxplesk15.openhost.net.nz [119.47.118.83])
 by mx.groups.io with SMTP id smtpd.web08.4232.1618957894963412209
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Apr 2021 15:31:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: bluelightning.org, ip: 119.47.118.83, mailfrom: bluelightning@bluelightning.org)
Received: from linc.localnet (unknown [151.210.226.152])
	by linuxplesk15.openhost.net.nz (Postfix) with ESMTPSA id 80BF0A0EF0;
	Wed, 21 Apr 2021 10:31:33 +1200 (NZST)
Authentication-Results: linuxplesk15.openhost.net.nz;
	spf=pass (sender IP is 151.210.226.152) smtp.mailfrom=bluelightning@bluelightning.org smtp.helo=linc.localnet
Received-SPF: pass (linuxplesk15.openhost.net.nz: connection is authenticated)
From: "Paul Eggleton" <bluelightning@bluelightning.org>
To: Diego Sueiro <diego.sueiro@arm.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: layerindex: Fix bitbake-layers layerindex-show-depends command
Date: Wed, 21 Apr 2021 10:31:33 +1200
Message-ID: <2160210.tdWV9SEqCh@linc>
In-Reply-To: <e810a80d2aa60cbfbca64abd52101a8c856c80c5.1618588951.git.diego.sueiro@arm.com>
References: <e810a80d2aa60cbfbca64abd52101a8c856c80c5.1618588951.git.diego.sueiro@arm.com>
MIME-Version: 1.0
X-PPP-Message-ID: <20210420223133.2624585.9058@localhost6.localdomain6>
X-PPP-Vhost: softec.co.nz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Diego

On Saturday, 17 April 2021 04:07:10 NZST Diego Sueiro wrote:
> Running 'bitbake-layers layerindex-show-depends meta-filesystems' fails
> with: ```
> Traceback (most recent call last):
>   File "<...>/poky/bitbake/bin/bitbake-layers", line 93, in <module>
>     ret = main()
>   File "<...>/poky/bitbake/bin/bitbake-layers", line 86, in main
>     return args.func(args)
>   File "<...>/poky/bitbake/lib/bblayers/layerindex.py", line 209, in
> do_layerindex_show_depends self.do_layerindex_fetch(args)
>   File "<...>/poky/bitbake/lib/bblayers/layerindex.py", line 182, in
> do_layerindex_fetch args.shallow)
> AttributeError: 'Namespace' object has no attribute 'shallow'
> ```
> 
> Initialize the shallow attribute to fix it.
> 
> Signed-off-by: Diego Sueiro <diego.sueiro@arm.com>
> ---
>  bitbake/lib/bblayers/layerindex.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/bitbake/lib/bblayers/layerindex.py
> b/bitbake/lib/bblayers/layerindex.py index b2f27b21ee..17dfc9874d 100644
> --- a/bitbake/lib/bblayers/layerindex.py
> +++ b/bitbake/lib/bblayers/layerindex.py
> @@ -206,6 +206,7 @@ class LayerIndexPlugin(ActionPlugin):
>  """
>          args.show_only = True
>          args.ignore = []
> +        args.shallow = True

Hmm, yes. We could probably use a test that ensures this doesn't regress 
again. Is that something you would be able to look at?

Thanks
Paul



