Received: from plane.gmane.org ([80.91.229.3])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gcsb-bitbake-dev@m.gmane.org>) id 1UcuiW-0002LF-HH
	for bitbake-devel@lists.openembedded.org;
	Thu, 16 May 2013 11:43:32 +0200
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsb-bitbake-dev@m.gmane.org>) id 1UcuCJ-0007pL-03
	for bitbake-devel@lists.openembedded.org;
	Thu, 16 May 2013 11:10:03 +0200
Received: from p5099b24a.dip0.t-ipconnect.de ([80.153.178.74])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00 for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 May 2013 11:10:02 +0200
Received: from m.meier by p5099b24a.dip0.t-ipconnect.de with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 May 2013 11:10:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: bitbake-devel@lists.openembedded.org
From: Michael <m.meier@plusoptix.de>
Date: Thu, 16 May 2013 11:03:50 +0200
Message-ID: <kn27dj$tdo$1@ger.gmane.org>
Mime-Version: 1.0
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5099b24a.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130211 Thunderbird/17.0.2
X-Mailman-Approved-At: Sun, 19 May 2013 10:50:59 +0200
Subject: Can't run bitbake with su -c
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
X-List-Received-Date: Thu, 16 May 2013 09:43:34 -0000
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi all,

if I call BitBake as super user like this: su <user> -c "bitbake
<recipe>" I get the following traceback:

Traceback (most recent call last):
  File "/usr/bin/bitbake", line 196, in <module>
    ret = main()
  File "/usr/bin/bitbake", line 160, in main
    cooker = bb.cooker.BBCooker(configuration, server)
  File "/usr/lib/python2.7/site-packages/bb/cooker.py", line 90, in __init__
    self.parseConfigurationFiles(self.configuration.file)
  File "/usr/lib/python2.7/site-packages/bb/cooker.py", line 570, in
parseConfigurationFiles
    data = bb.parse.handle(os.path.join("conf", "bitbake.conf"), data)
  File "/usr/lib/python2.7/site-packages/bb/parse/__init__.py", line 75,
in handle
    return h['handle'](fn, data, include)
  File
"/usr/lib/python2.7/site-packages/bb/parse/parse_py/ConfHandler.py",
line 104, in handle
    statements.eval(data)
  File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in eval
    map(lambda x: x.eval(data), self)
  File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in
<lambda>
    map(lambda x: x.eval(data), self)
  File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 56, in eval
    bb.parse.ConfHandler.include(self.from_fn, s, data, False)
  File
"/usr/lib/python2.7/site-packages/bb/parse/parse_py/ConfHandler.py",
line 66, in include
    ret = handle(fn, data, True)
  File "/usr/lib/python2.7/site-packages/bb/parse/__init__.py", line 75,
in handle
    return h['handle'](fn, data, include)
  File
"/usr/lib/python2.7/site-packages/bb/parse/parse_py/ConfHandler.py",
line 104, in handle
    statements.eval(data)
  File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in eval
    map(lambda x: x.eval(data), self)
  File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in
<lambda>
    map(lambda x: x.eval(data), self)
  File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 54, in eval
    bb.parse.ConfHandler.include(self.from_fn, s, data, "include required")
  File
"/usr/lib/python2.7/site-packages/bb/parse/parse_py/ConfHandler.py",
line 66, in include
    ret = handle(fn, data, True)
  File "/usr/lib/python2.7/site-packages/bb/parse/__init__.py", line 75,
in handle
    return h['handle'](fn, data, include)
  File
"/usr/lib/python2.7/site-packages/bb/parse/parse_py/BBHandler.py", line
149, in handle
    statements.eval(d)
  File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in eval
    map(lambda x: x.eval(data), self)
  File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 33, in
<lambda>
    map(lambda x: x.eval(data), self)
  File "/usr/lib/python2.7/site-packages/bb/parse/ast.py", line 92, in eval
    bb.data.update_data(e)
  File "/usr/lib/python2.7/site-packages/bb/data.py", line 486, in
update_data
    overrides = (getVar('OVERRIDES', d, 1) or "").split(':') or []
  File "/usr/lib/python2.7/site-packages/bb/data.py", line 100, in getVar
    return d.getVar(var,exp)
  File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 165, in
getVar
    return self.expand(value,var)
  File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 82, in
expand
    s = __expand_var_regexp__.sub(var_sub, s)
  File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 60, in
var_sub
    var = self.getVar(key, 1)
  File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 165, in
getVar
    return self.expand(value,var)
  File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 83, in
expand
    s = __expand_python_regexp__.sub(python_sub, s)
  File "/usr/lib/python2.7/site-packages/bb/data_smart.py", line 69, in
python_sub
    s = utils.better_eval(codeobj, {"d": self})
  File "/usr/lib/python2.7/site-packages/bb/utils.py", line 360, in
better_eval
    return eval(source, _context, locals)
  File "PN", line 1, in <module>
TypeError: getVar() takes exactly 3 arguments (2 given)

I've tried it with BitBake from
git://github.com/openembedded/bitbake.git, master-branch,
commit:c47088a86fd8ad06c1810d04d9537c4cd01e8bef as well as commit:
782bc0e797802224f06cb6f9098a50d658c86523

In previous BitBake-Versions (about 1.10.0) it was possible to call
BitBake this way.

Any ideas how do fix this issue?

Thanks in advance!

Michael



