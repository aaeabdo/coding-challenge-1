class V1 < BaseResource
  # TODO: implement pagination
  # TODO: implement filtering
  # TODO: refactor resource method in logic
  get %r{/packages} do
    packages = Package.all
    Representers::V1::Package.collection(packages).to_json
  end
end

