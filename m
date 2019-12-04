Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
	[209.85.216.65])
	by mail.openembedded.org (Postfix) with ESMTP id A80F47E422
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Dec 2019 18:20:14 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id ep17so149341pjb.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Dec 2019 10:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=4U+F/Carxuk7LUGhSDrlTjvYI+OBMtRCmVnGR98H/w8=;
	b=JhOHRGqVvcU7XrMLfHgWTYs7KrVgDGIyypoMLEgutMKGz/gyX4KraCQ8tVXaBB1RLS
	kMl7yXJ5TJolrFttBbPdV/RoH8dbpKGOcmMv/dJ4AjwrepvZZoi7ctbcFX6ojoesb/Gr
	ApMlGk+cXWxbLaPIafhqsykal4OJSAN2DKfLVG85VkaHQW0rvwMWlMELUVD0TuY2sWfp
	EjsRbihN6XUqQqyD+oleLoa+2CPoXyV3s7KXse/A3ciSBVqlHi3Pw2Prt6QIOFbKzqwy
	0vqeDJcHE9MTSXcTQ1qCOMbRJ3CLihdqtHmi1blRZf09ZT8gQJzfo9KafthvLlchhqDT
	a3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=4U+F/Carxuk7LUGhSDrlTjvYI+OBMtRCmVnGR98H/w8=;
	b=jzLs5rlfzc0jyIv6QWVupbJzeWULJHeA8OORmi9I/6+FTRAqR8uI2Oz6G/uWrP8LQg
	qMhKxzZOy4wUNUQvuk9GUjJqhYLwQ9gkaMNr+XSuoZJ/W6HQ6fixEZB0eo1rqP6hoCON
	2Yl2kS2cnQvovpUeDG6dIiWWKVeJMdtzzbEZ6btZM5FWaSdpmyUjbQKdxGRU8peIAbam
	qogGHVb6PSLgvr6kP0IQsYAmwYS/CL4qOX95PcxilxdZ6HuSsaauXf+dVR675jqzsO2n
	/+u3KvZZD4PY5tDVTlVKFIVe6dh5h1/cWXj0syW9q0NB6bs5nFTUXRjaqgcKEIzC+/Kf
	oYZA==
X-Gm-Message-State: APjAAAWvf3Ue5qGPiKaypfQPT5BPq8cncQWIusBsiSaTLpaOtenmKKUu
	R73QooTLk9ZdehU39Z8WjGQ+O9jw
X-Google-Smtp-Source: APXvYqwWAsZK8OcqS61Ua4Rj9AgjLTD4Ae7EdQPT2GiMShJyabcV+Medq6JWATY3YmP0zxw1dm/oXA==
X-Received: by 2002:a17:902:8b89:: with SMTP id
	ay9mr4549287plb.314.1575483615422; 
	Wed, 04 Dec 2019 10:20:15 -0800 (PST)
Received: from ?IPv6:2601:202:4180:a5c0:ddfa:6ede:7f7:8153?
	([2601:202:4180:a5c0:ddfa:6ede:7f7:8153])
	by smtp.gmail.com with ESMTPSA id
	d65sm8979910pfa.159.2019.12.04.10.20.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 04 Dec 2019 10:20:14 -0800 (PST)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <20191204115302.24692-1-richard.purdie@linuxfoundation.org>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <ce3c43d8-9d74-366a-145b-ca6d78778235@gmail.com>
Date: Wed, 4 Dec 2019 10:20:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204115302.24692-1-richard.purdie@linuxfoundation.org>
Subject: Re: [PATCH 1/4] hashserv: Add support for equivalent hash reporting
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
X-List-Received-Date: Wed, 04 Dec 2019 18:20:14 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 12/4/19 3:52 AM, Richard Purdie wrote:
> The reason for this should be recorded in the commit logs. Imagine
> you have a target recipe (e.g. meta-extsdk-toolchain) which depends on
> gdb-cross. sstate in OE-Core allows gdb-cross to have the same hash
> regardless of whether its built on x86 or arm. The outhash will be
> different.
>
> We need hashequiv to be able to adapt to the prescence of sstate artefacts
> for meta-extsdk-toolchain and allow the hashes to re-intersect, rather than
> trying to force a rebuild of meta-extsdk-toolchain. By this point in the build,
> it would have already been installed from sstate so the build needs to adapt.
>
> Equivalent hashes should be reported to the server as a taskhash that
> needs to map to an specific unihash. This patch adds API to the hashserv
> client/server to allow this.
>
> [Thanks to Joshua Watt for help with this patch]

This sounds like 1.44 backport worthy?

- armin
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/hashserv/client.py |  8 ++++++++
>  lib/hashserv/server.py | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
> index f65956617b..ae0cce9df4 100644
> --- a/lib/hashserv/client.py
> +++ b/lib/hashserv/client.py
> @@ -148,6 +148,14 @@ class Client(object):
>          m['unihash'] = unihash
>          return self.send_message({'report': m})
>  
> +    def report_unihash_equiv(self, taskhash, method, unihash, extra={}):
> +        self._set_mode(self.MODE_NORMAL)
> +        m = extra.copy()
> +        m['taskhash'] = taskhash
> +        m['method'] = method
> +        m['unihash'] = unihash
> +        return self.send_message({'report-equiv': m})
> +
>      def get_stats(self):
>          self._set_mode(self.MODE_NORMAL)
>          return self.send_message({'get-stats': None})
> diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> index 0aff77688e..cc7e48233b 100644
> --- a/lib/hashserv/server.py
> +++ b/lib/hashserv/server.py
> @@ -143,6 +143,7 @@ class ServerClient(object):
>              handlers = {
>                  'get': self.handle_get,
>                  'report': self.handle_report,
> +                'report-equiv': self.handle_equivreport,
>                  'get-stream': self.handle_get_stream,
>                  'get-stats': self.handle_get_stats,
>                  'reset-stats': self.handle_reset_stats,
> @@ -303,6 +304,41 @@ class ServerClient(object):
>  
>          self.write_message(d)
>  
> +    async def handle_equivreport(self, data):
> +        with closing(self.db.cursor()) as cursor:
> +            insert_data = {
> +                'method': data['method'],
> +                'outhash': "",
> +                'taskhash': data['taskhash'],
> +                'unihash': data['unihash'],
> +                'created': datetime.now()
> +            }
> +
> +            for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginfo'):
> +                if k in data:
> +                    insert_data[k] = data[k]
> +
> +            cursor.execute('''INSERT OR IGNORE INTO tasks_v2 (%s) VALUES (%s)''' % (
> +                ', '.join(sorted(insert_data.keys())),
> +                ', '.join(':' + k for k in sorted(insert_data.keys()))),
> +                insert_data)
> +
> +            self.db.commit()
> +
> +            # Fetch the unihash that will be reported for the taskhash. If the
> +            # unihash matches, it means this row was inserted (or the mapping
> +            # was already valid)
> +            row = self.query_equivalent(data['method'], data['taskhash'])
> +
> +            if row['unihash'] == data['unihash']:
> +                logger.info('Adding taskhash equivalence for %s with unihash %s',
> +                                data['taskhash'], row['unihash'])
> +
> +            d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
> +
> +        self.write_message(d)
> +
> +
>      async def handle_get_stats(self, request):
>          d = {
>              'requests': self.request_stats.todict(),


