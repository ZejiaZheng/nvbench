#include <nvbench/type_axis.cuh>

#include <nvbench/types.cuh>

#include "test_asserts.cuh"

#include <fmt/format.h>

void test_empty()
{
  nvbench::type_axis axis("Basic", 0);

  ASSERT(axis.get_name() == "Basic");
  ASSERT(axis.get_axis_index() == 0);
  ASSERT(axis.get_type() == nvbench::axis_type::type);
  ASSERT(axis.get_size() == 0);

  axis.set_inputs<nvbench::type_list<>>();

  ASSERT(axis.get_size() == 0);

  const auto clone_base = axis.clone();
  ASSERT(clone_base.get() != nullptr);
  const auto *clone =
    dynamic_cast<const nvbench::type_axis *>(clone_base.get());
  ASSERT(clone != nullptr);

  ASSERT(clone->get_name() == "Basic");
  ASSERT(clone->get_axis_index() == 0);
  ASSERT(clone->get_type() == nvbench::axis_type::type);
  ASSERT(clone->get_size() == 0);
}

void test_single()
{
  nvbench::type_axis axis("Single", 0);
  axis.set_inputs<nvbench::type_list<nvbench::int32_t>>();

  ASSERT(axis.get_name() == "Single");
  ASSERT(axis.get_size() == 1);
  ASSERT(axis.get_input_string(0) == "I32");
  ASSERT(axis.get_description(0) == "int32_t");

  const auto clone_base = axis.clone();
  ASSERT(clone_base.get() != nullptr);
  const auto *clone =
    dynamic_cast<const nvbench::type_axis *>(clone_base.get());
  ASSERT(clone != nullptr);

  ASSERT(clone->get_name() == "Single");
  ASSERT(clone->get_size() == 1);
  ASSERT(clone->get_input_string(0) == "I32");
  ASSERT(clone->get_description(0) == "int32_t");
}

void test_several()
{
  nvbench::type_axis axis("Several", 0);
  axis.set_inputs<
    nvbench::type_list<nvbench::int32_t, nvbench::float64_t, bool>>();

  ASSERT(axis.get_name() == "Several");
  ASSERT(axis.get_size() == 3);
  ASSERT(axis.get_input_string(0) == "I32");
  ASSERT(axis.get_description(0) == "int32_t");
  ASSERT(axis.get_input_string(1) == "F64");
  ASSERT(axis.get_description(1) == "double");
  ASSERT(axis.get_input_string(2) == "bool");
  ASSERT(axis.get_description(2) == "");

  const auto clone_base = axis.clone();
  ASSERT(clone_base.get() != nullptr);
  const auto *clone =
    dynamic_cast<const nvbench::type_axis *>(clone_base.get());
  ASSERT(clone != nullptr);

  ASSERT(clone->get_name() == "Several");
  ASSERT(clone->get_size() == 3);
  ASSERT(clone->get_input_string(0) == "I32");
  ASSERT(clone->get_description(0) == "int32_t");
  ASSERT(clone->get_input_string(1) == "F64");
  ASSERT(clone->get_description(1) == "double");
  ASSERT(clone->get_input_string(2) == "bool");
  ASSERT(clone->get_description(2) == "");
}

void test_get_type_index()
{
  nvbench::type_axis axis("GetIndexTest", 0);
  axis.set_inputs<
    nvbench::
      type_list<nvbench::int8_t, nvbench::uint16_t, nvbench::float32_t, bool>>();

  ASSERT(axis.get_type_index("I8") == 0);
  ASSERT(axis.get_type_index("U16") == 1);
  ASSERT(axis.get_type_index("F32") == 2);
  ASSERT(axis.get_type_index("bool") == 3);

  const auto clone_base = axis.clone();
  ASSERT(clone_base.get() != nullptr);
  const auto *clone =
    dynamic_cast<const nvbench::type_axis *>(clone_base.get());
  ASSERT(clone != nullptr);

  ASSERT(clone->get_type_index("I8") == 0);
  ASSERT(clone->get_type_index("U16") == 1);
  ASSERT(clone->get_type_index("F32") == 2);
  ASSERT(clone->get_type_index("bool") == 3);
}

int main()
{
  test_empty();
  test_single();
  test_several();
  test_get_type_index();
}
