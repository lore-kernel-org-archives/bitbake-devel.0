Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Ue0HR-0004xH-AF for bitbake-devel@lists.openembedded.org;
	Sun, 19 May 2013 11:52:00 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4J9asBI031365; Sun, 19 May 2013 10:36:54 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ArCt3O26M6hR; Sun, 19 May 2013 10:36:54 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4J9aowO031325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sun, 19 May 2013 10:36:52 +0100
Message-ID: <1368956002.32727.72.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Michael <m.meier@plusoptix.de>
Date: Sun, 19 May 2013 12:33:22 +0300
In-Reply-To: <kn27dj$tdo$1@ger.gmane.org>
References: <kn27dj$tdo$1@ger.gmane.org>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Can't run bitbake with su -c
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
X-List-Received-Date: Sun, 19 May 2013 09:52:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-05-16 at 11:03 +0200, Michael wrote:
> Hi all,
> 
> if I call BitBake as super user like this: su <user> -c "bitbake
> <recipe>" I get the following traceback:
> 
> Traceback (most recent call last):
>   File "/usr/bin/bitbake", line 196, in <module>
>     ret = main()
>   File "/usr/bin/bitbake", line 160, in main
>     cooker = bb.cooker.BBCooker(configuration, server)
>   File "/usr/lib/python2.7/site-packages/bb/cooker.py", line 90, in __init__
>     self.parseConfigurationFiles(self.configuration.file)
>   File "/usr/lib/python2.7/site-packages/bb/cooker.py", line 570, in
> parseConfigurationFiles
>     data = bb.parse.handle(os.path.join("conf", "bitbake.conf"), data)
>   File "/usr/lib/python2.7/site-packages/bb/parse/__init__.py", line 75,
> in handle
>     return h['handle'](fn, data, include)
>   File
> "/usr/lib/python2.7/site-packages/bb/parse/parse_py/ConfHandler.py",
> line 104, in handle
>     statements.eval(data)
>   File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in eval
>     map(lambda x: x.eval(data), self)
>   File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in
> <lambda>
>     map(lambda x: x.eval(data), self)
>   File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 56, in eval
>     bb.parse.ConfHandler.include(self.from_fn, s, data, False)
>   File
> "/usr/lib/python2.7/site-packages/bb/parse/parse_py/ConfHandler.py",
> line 66, in include
>     ret = handle(fn, data, True)
>   File "/usr/lib/python2.7/site-packages/bb/parse/__init__.py", line 75,
> in handle
>     return h['handle'](fn, data, include)
>   File
> "/usr/lib/python2.7/site-packages/bb/parse/parse_py/ConfHandler.py",
> line 104, in handle
>     statements.eval(data)
>   File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in eval
>     map(lambda x: x.eval(data), self)
>   File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in
> <lambda>
>     map(lambda x: x.eval(data), self)
>   File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 54, in eval
>     bb.parse.ConfHandler.include(self.from_fn, s, data, "include required")
>   File
> "/usr/lib/python2.7/site-packages/bb/parse/parse_py/ConfHandler.py",
> line 66, in include
>     ret = handle(fn, data, True)
>   File "/usr/lib/python2.7/site-packages/bb/parse/__init__.py", line 75,
> in handle
>     return h['handle'](fn, data, include)
>   File
> "/usr/lib/python2.7/site-packages/bb/parse/parse_py/BBHandler.py", line
> 149, in handle
>     statements.eval(d)
>   File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in eval
>     map(lambda x: x.eval(data), self)
>   File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in
> <lambda>
>     map(lambda x: x.eval(data), self)
>   File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 92, in eval
>     bb.data.update_data(e)
>   File "/usr/lib/python2.7/site-packages/bb/data.py", line 486, in
> update_data
>     overrides = (getVar('OVERRIDES', d, 1) or "").split(':') or []
>   File "/usr/lib/python2.7/site-packages/bb/data.py", line 100, in getVar
>     return d.getVar(var,exp)
>   File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 165, in
> getVar
>     return self.expand(value,var)
>   File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 82, in
> expand
>     s = __expand_var_regexp__.sub(var_sub, s)
>   File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 60, in
> var_sub
>     var = self.getVar(key, 1)
>   File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 165, in
> getVar
>     return self.expand(value,var)
>   File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 83, in
> expand
>     s = __expand_python_regexp__.sub(python_sub, s)
>   File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 69, in
> python_sub
>     s = utils.better_eval(codeobj, {"d": self})
>   File "/usr/lib/python2.7/site-packages/bb/utils.py", line 360, in
> better_eval
>     return eval(source, _context, locals)
>   File "PN", line 1, in <module>
> TypeError: getVar() takes exactly 3 arguments (2 given)
> 
> I've tried it with BitBake from
> git://github.com/openembedded/bitbake.git, master-branch,
> commit:c47088a86fd8ad06c1810d04d9537c4cd01e8bef as well as commit:
> 782bc0e797802224f06cb6f9098a50d658c86523

Can you do something like a print(source) before this line and see what
code its failing on please?

Cheers,

Richard



