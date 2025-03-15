defmodule FunnelWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use FunnelWeb, :controller` and
  `use FunnelWeb, :live_view`.
  """
  use FunnelWeb, :html

  embed_templates "layouts/*"
end
